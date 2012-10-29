require 'jinx/helpers/hasher'

module Jinx
  module JSON
    # This Deserializable mix-in adds a {Deserializer} to each class which extends this module.
    module Deserializable
      def included(other)
        super
        if Class === other then
          other.extend(Deserializer)
        else
          other.extend(Deserializable)
        end
      end
    end
  end
end
