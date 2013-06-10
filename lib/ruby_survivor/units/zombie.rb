module RubySurvivor
  module Units
    class Zombie < Base
      def initialize
        add_abilities :attack!, :walk!, :feel, :listen, :direction_of
      end
      
      def play_turn(turn)
        [:forward, :left, :right, :backward].each do |direction|
          if turn.feel(direction).player?
            turn.attack!(direction)
            return
          end
        end

        # walk towards the player if not standing next to it
        survivor_space = turn.listen.map { |space| space.survivor? }.first
        turn.walk!(turn.direction_of(survivor_space))
      end
      
      def attack_power
        3
      end
      
      def max_health
        12
      end
      
      def character
        "z"
      end
    end
  end
end
