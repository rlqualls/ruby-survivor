module RubySurvivor
  module Units
    class Base < RubySurvivor::Entity
      attr_writer :health
      attr_accessor :position
      
      def attack_power
        0
      end
       
      def earn_points(points)
      end
       
      def bound?
        @bound
      end
      
      def unbind
        say "released from bonds"
        @bound = false
      end
      
      def bind
        @bound = true
      end
         
    end
  end
end
