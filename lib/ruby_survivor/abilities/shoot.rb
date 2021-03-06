module RubySurvivor
  module Abilities
    class Shoot < Base
      def description
        "Shoot your gun in given direction (forward by default)."
      end
      
      def perform(direction = :forward)
        if @unit.has?(:shotgun)
          verify_direction(direction)
          receiver = multi_unit(direction, 1..3).compact.first
          if receiver
            @unit.say "shoots #{direction} and hits #{receiver}"
            damage(receiver, @unit.shoot_power)
          else
            @unit.say "shoots and hits nothing"
          end
        else
          @unit.say "wants to shoot but does not have anything to shoot with"
        end
      end
      
      def multi_unit(direction, range)
        range.map { |n| target(direction, n) }
      end
    end
  end
end
