module RubySurvivor
  module Abilities
    class Run < Base

      STAMINA_COST = 5

      def description
        "Move two spaces in the given direction (forward by default). Costs 5 stamina."
      end
      
      def perform(direction = :forward)
        verify_direction(direction)
        if @unit.position
          if @unit.stamina >= STAMINA_COST
            @unit.lose_stamina(STAMINA_COST)
            @unit.say "runs #{direction}"
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
          else
            @unit.say "is too fatigued too run"
          end
        end
      end
    end
  end
end
