module RubySurvivor
  module Units
    class Survivor < Base
      attr_writer :name
      attr_reader :score
      
      def initialize
        @score = 0 # TODO make score dynamic
        @inventory = []
      end
      
      def play_turn(turn)
        player.play_turn(turn)
      end
      
      def player
        @player ||= Player.new
      end
      
      def earn_points(points)
        @score += points
        say "earns #{points} points"
      end
      
      def attack_power
        5
      end
      
      def shoot_power
        3
      end
      
      def max_health
        20
      end
      
      def name
        if @name && !@name.empty?
          @name
        else
          "Survivor"
        end
      end

      def has?(item)
        @inventory.include?(item)
      end

      def give(item)
        @inventory << item
      end

      def take(item)
        @inventory.delete_at(@inventory.index(item) || @inventory.length)
      end
      
      def to_s
        name
      end
      
      def character
        "@"
      end
      
      def perform_turn
        say "does nothing" if @current_turn.action.nil?
        super
      end
      
    end
  end
end
