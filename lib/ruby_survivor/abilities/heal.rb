module RubySurvivor
  module Abilities
    class Heal < Base
      def description
        "Gain 50% of max health back by using a medpack"
      end
      
      def perform
        if @unit.kind_of?(RubySurvivor::Units::Survivor)
          if @unit.health < @unit.max_health
            if @unit.has?(:medpack)
              @unit.take(:medpack)
              amount = (@unit.max_health*0.5).round
              amount = @unit.max_health-@unit.health if (@unit.health + amount) > @unit.max_health
              @unit.health += amount
              @unit.say "uses a medpack and receives #{amount} health from healing, up to #{@unit.health} health"
            else
              @unit.say "can't find a medpack to heal with"
            end
          else
            @unit.say "is already in perfect condition"
          end
        else
          @unit.say "does not know how to use a medpack"
        end
      end
    end
  end
end
