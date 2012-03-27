require 'jinx/json/deserializer'

module Jinx
  module JSON
    # Augments +Jinx::Importer+ to extend every jinxed class with a deserializer.
    module Importer
      private
      
      # Augments +Jinx::Importer.add_metadata+ to extend the introspected class
      # with a deserializer.
      #
      # @param [Class] the class to introspect
      def add_metadata(klass)
        super
        klass.extend(Deserializer)
      end
    end
  end
end
