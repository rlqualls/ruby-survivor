module RubySurvivor
  module Units
    class Base < RubySurvivor::Entity
      attr_writer :health
      attr_accessor :position
      
      def attack_power
        0
      end
       
      def take_damage(amount)
        unbind if bound? 
        if health
          self.health -= amount
          say "takes #{amount} damage, #{health} health left"
          if health <= 0
            @position = nil
            say "dies"
          end
        end
      end 

      def bound?
        @bound
      end
      
      def unbind
        say "is released from bonds"
        @bound = false
      end
      
      def bind
        @bound = true
      end

      def perform_turn
        if @position
          abilities.values.each do |ability|
            ability.pass_turn
          end
          if @current_turn.action && !bound?
            name, *args = @current_turn.action
            abilities[name].perform(*args)
          end
        end
      end
         
    end
  end
end
