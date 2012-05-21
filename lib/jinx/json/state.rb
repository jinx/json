require 'set'

module Jinx
  module JSON
    # This State module bumps the JSON default +:max_nesting+ to 100 and tracks
    # the visited objects in a modified +JSON::Pure::Generator::State+.
    module State
      # @param [Hash, nil] opts the generator options
      # return [State] the state for the given options
      def self.for(opts)
        opts ||= {}
        opts[:max_nesting] ||= 100
        state = ::JSON::Pure::Generator::State.from_state(opts)
        class << state 
          # @return [<Jinx::JSON::Serializable>] the serialized objects
          def visited
            @visited ||= Set.new
          end
        end
        state
      end
    end
  end
end
