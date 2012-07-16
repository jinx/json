require 'jinx/helpers/collection'
require 'jinx/json/state'

module Jinx
  module Collection
    # Adds JSON serialization to collections.
    #
    # @param [State, Hash, nil] state the JSON state or serialization options
    # @return [String] the JSON representation of this {Jinx::Resource}
    def to_json(state=nil)
      # Make a new State from the options if this is a top-level call.
      state = JSON::State.for(state) unless JSON::State === state
      to_a.to_json(state)
    end
  end
end
