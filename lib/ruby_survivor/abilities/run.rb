module RubySurvivor
  module Abilities
    class Run < Base
      def description
        "Move faster in the given direction (forward by default)."
      end
      
      def perform(direction = :forward)
        verify_direction(direction)
        if @unit.position
          @unit.say "walks #{direction}"
          if space(direction).empty?
            @unit.position.move(*offset(direction))
            if space(direction).empty?
              @unit.position.move(*offset(direction))
            else
              @unit.say "bumps into #{space(direction)}"
            end
          else
            @unit.say "bumps into #{space(direction)}"
          end
        end
      end
    end
  end
end
