module RubySurvivor
  module Abilities
    class Listen < Base
      def description
        "Returns an array of all spaces which have units in them."
      end
      
      def perform
        @unit.position.floor.entities.map do |entity|
          entity.position.space unless entity == @unit
        end.compact
      end
    end
  end
end
