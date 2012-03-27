require 'jinx/helpers/collection'

module Jinx
  module Collection
    # Adds JSON serialization to collections.
    #
    # @param args the JSON serialization options
    # @return [String] the JSON representation of this Enumerable as an array
    def to_json(*args)
      to_a.to_json(*args)
    end
  end
end
