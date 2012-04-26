require 'jinx/helpers/hashable'

module JSON
  # Bumps the default JSON nesting level to 100.
  def self.parse(source, opts={})
    visited = Thread.current[:jinx_json_deserialized] ||= {}
    opts = opts.merge(:max_nesting => 100) unless opts.has_key?(:max_nesting) 
    begin
      Parser.new(source, opts).parse
    ensure
      visited.clear
    end
  end
end

module Jinx
  module JSON
    # JSON => {Jinx::Resource} deserializer.
    #
    # This Deserializer reconstitutes a jinxed object from a JSON string built
    # by a {Serializable}.
    module Deserializer
      # @param [String] json the JSON to deserialize
      # @return [Jinx::Resource] the deserialized object
      def json_create(json)
        # the thread-local oid => object hash
        visited = Thread.current[:jinx_json_deserialized]
        # the payload
        vh = json['data']
        # the oid
        oid = vh.delete('object_id')
        # If the object has already been built, then return that object.
        ref = visited[oid]
        if ref then
          # Fill in a place-holder with content.
          ref.merge_attributes(vh) unless vh.empty?
          return ref
        end
        # Make the new object from the attribute => value hash.
        visited[oid] = new(vh)
      end
    end
  end
end
