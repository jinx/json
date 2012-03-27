require 'json'
require 'jinx/json/collection'
require 'jinx/json/importer'

module Jinx
  module JSON
    # {Jinx::Resource} => JSON serializer.
    #
    # This Serializer creates a JSON string from a jinxed object. The JSON payload is
    # suitable for transfer to a remote {Deserializer}. This {Serializer} is included
    # directly in the jinxed application domain module after including {Jinx::Resource},
    # e.g.:
    #   module MyApp
    #     include Jinx::JSON::Serializer, Jinx:Resource
    # which includes +Resource+ followed by the +Serializer+.
    #
    # The module which includes this Serializer is extended with the {Importer}, which
    # enables deserialization of the serialized JSON.
    #
    # The JSON payload is built as follows:
    # * non-domain properties are serialized
    # * dependent references are serialized recursively
    # * independent reference primary and secondary key content is serialized
    module Serializer
      # @param args the JSON serialization options
      # @return [String] the JSON representation of this {Jinx::Resource}
      def to_json(*args)
        {
          'json_class' => json_class_name,
          'data' => json_value_hash
        }.to_json(*args)
      end
      
      # Extends the including module with {Importer}.
      #
      # @param [Module] mod the including module
      def self.included(mod)
        super
        mod.extend(Importer)
      end
      
      private
      
      # The JSON class name must be scoped by the Resource package module, not the
      # Java package, in order to recognize the Jinx::Resource JSON hooks.
      #
      # @return [String] the class name qualified by the Resource package module name context
      def json_class_name
        [self.class.domain_module, self.class.name.demodulize].join('::')
      end
      
      # Builds a serializable attribute => value hash. If _key_only _ is true, then only
      # the key attributes are included in the hash. Otherwise, all properties are included
      # in the hash.
      #
      # An independent or owner attribute value is a copy of the referenced domain object
      # consisting of only the primary and secondary key attributes.
      #
      # @return [{Symbol => Object}] the serializable value hash
      def json_value_hash
        vh = value_hash(self.class.nondomain_attributes)
        vh.merge!(value_hash(self.class.dependent_attributes))
        self.class.independent_attributes.each do |ia|
          ref = send(ia)
          vh[ia] = json_independent_reference(ref) unless ref.nil_or_empty?
        end
        vh
      end
      
      # @param [Resource] the referenced object
      # @return [Resource] a copy of the referenced object which only contains
      #   key property values
      def json_independent_reference(ref)
        return ref.map { |item| json_independent_reference(item) } if ref.collection?
        vh = json_key_hash(ref)
        ref.copy(vh) unless vh.empty?
      end
      
      # @param (see #json_independent_reference)
      # @return [{Symbol => Object}, nil] the key attribute => value hash, or nil
      #   if there is no complete key
      def json_key_hash(ref)
        vh = ref.value_hash(ref.class.primary_key_attributes)
        ref.class.secondary_key_attributes.each do |ka|
          value = json_key_value(ref, ka)
          vh[ka] = value if value
        end
      end
      
      # @param (see #json_independent_reference)
      # @param [Symbol] the key value
      # @return the key attribute value
      def json_key_value(ref, attribute)
        value = ref.send(attribute)
        Resource === value ? json_independent_reference(value) : value
      end
    end
  end
end
