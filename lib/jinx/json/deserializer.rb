require 'jinx/helpers/hashable'

module Jinx
  module JSON
    # JSON => {Jinx::Resource} deserializer.
    #
    # This Deserializer reconstitutes a jinxed object from a JSON string built by a {Serializer}.
    module Deserializer
      # @param [String] json the JSON to deserialize
      # @return [Jinx::Resource] the deserialized object
      def json_create(json)
        # Make the new object from the json data attribute => value hash.
        new(json['data'])
      end
    end
  end
end
