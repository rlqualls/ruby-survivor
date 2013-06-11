module RubySurvivor
  module Abilities
    class Swing < Base

      STAMINA_COST = 5

      def description
        "Attacks a unit in given direction with a baseball bat (forward by default). Costs 5 stamina."
      end
       
      def perform(direction = :forward)
        verify_direction(direction)
        receiver = unit(direction)
        if receiver
          if @unit.stamina >= STAMINA_COST
            if direction == :backward
              power = (@unit.attack_power).ceil
            else
              power = @unit.attack_power * damage_multiplier           
            end
            @unit.say "swings #{direction} and hits #{receiver} for #{power} damage"
            damage(receiver, power)
            @unit.lose_stamina(STAMINA_COST)
          end
        else
          @unit.say "swings #{direction} and hits nothing"
        end
      end

      def damage_multiplier
        (rand(1.5) + 1.5)
      end
    end
  end
end
