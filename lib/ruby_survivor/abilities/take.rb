module RubySurvivor
  module Abilities
    class Take < Base
      def description
        "Pick up an item in the given direction (forward by default)."
      end
      
      def perform(direction = :forward)
        if @unit.kind_of?(RubySurvivor::Units::Survivor)
          verify_direction(direction)
          if space(direction).item?
            item = target(direction)
            @unit.give(item.type)
            item.remove
          else
            @unit.say "tries to take something but it's not an item"
          end
        end
      end
    end
  end
end
