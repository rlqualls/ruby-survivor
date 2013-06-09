module RubySurvivor
  module Items
    class Base
      attr_accessor :position
       
      def remove
        @position = nil
      end

      def say(msg)
        UI.puts_with_delay "#{name} #{msg}"
      end
      
      def name
        self.class.name.split('::').last.titleize
      end
      alias_method :to_s, :name
       
      def character
        "?"
      end

      def type
        :nothing
      end
    end
  end
end
