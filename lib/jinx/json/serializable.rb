require 'json'
require 'jinx/json/state'
require 'jinx/json/collection'
require 'jinx/json/date'
require 'jinx/json/deserializable'
require 'jinx/json/deserializer'

module Jinx
  module JSON
    # Serializable is the JSON serializer {Jinx::Resource} mix-in.
    #
    # {#to_json} creates a JSON string from a jinxed object. The JSON payload is
    # suitable for transfer to a remote {Deserializer}. This {Serializable} module
    # is included directly in the jinxed application domain module after
    # including {Jinx::Resource}, e.g.:
    #   module MyApp
    #     include Jinx::JSON::Serializable, Jinx:Resource
    # which includes +Resource+ followed by the +Serializable+.
    #
    # The module which includes Serializable is extended with the {Importer}, which
    # enables deserialization of the serialized JSON.
    #
    # The JSON payload is built as follows:
    # * non-domain properties are serialized
    # * dependent references are serialized recursively
    # * independent reference primary and secondary key content is serialized
    # * circular references are precluded by truncating the reference with a
    #   surrogate object id
    module Serializable
      def self.included(other)
        super
        if Class === other then
          other.extend(Deserializer)
        else
          other.extend(Deserializable)
        end
      end
      
      # @param [State, Hash, nil] state the JSON state or serialization options
      # @return [String] the JSON representation of this {Jinx::Resource}
      def to_json(state=nil)
        # Make a new State from the options if this is a top-level call.
        state = State.for(state) unless State === state
        # the JSON content
        {
          'json_class' => json_class_name,
          'data' => json_value_hash(state.visited)
        }.to_json(state)
      end

      private

      # The JSON class name must be scoped by the Resource package module, not the
      # Java package, in order to recognize the Jinx::Resource JSON hooks.
      #
      # @return [String] the class name qualified by the Resource package module name context
      def json_class_name
        [self.class.domain_module, self.class.name.demodulize].join('::')
      end

      # Builds a serializable attribute => value hash with content as follows:
      # * If this domain object has not yet been visited, then the hash includes all attributes,
      #   as well as the +Jinx::Resource#proxy_object_id+.
      # * If this domain object has already been visited, then the hash includes only the
      #   +proxy_object_id+.
      # Each +Set+ attribute value is converted to an array, since JSON does not serialize
      # a +Set+ properly.
      #
      # The {Deserializer} is responsible for reconstituting the domain object graph from the
      # serialized content.
      #
      # @param [<Resource>] visited the serialized objects
      # @return [{Symbol => Object}] the serializable value hash
      def json_value_hash(visited)
        # If already visited, then the only content is the object id.
        if visited.include?(self) then
          return {:object_id => proxy_object_id}
        end
        visited << self
        vh = value_hash(self.class.java_attributes)
        vh.each { |pa, v| vh[pa] = v.to_a if Set === v } 
        # Add the object id.
        vh[:object_id] = proxy_object_id
        vh
      end
    end
  end
end
