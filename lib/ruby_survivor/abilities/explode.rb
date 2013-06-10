module RubySurvivor
  module Abilities
    class Explode < Base
      attr_accessor :time
      
      def description
        "Kills you and all surrounding units. You probably don't want to do this intentionally."
      end
      
      def perform
        if @unit.position
          @unit.say "explodes, collapsing the ceiling and damanging every unit."
          @unit.position.floor.entities.map do |entity|
            entity.take_damage(100)
          end
        end
      end
      
      def pass_turn
        if @time && @unit.position
          @unit.say "is ticking"
          @time -= 1
          perform if @time.zero?
        end
      end
    end
  end
end
