module RubySurvivor
  class Floor
    attr_accessor :width, :height, :grid
    attr_reader :exit_location
    
    def initialize
      @width = 0
      @height = 0
      @entities = []
      @exit_location = [-1, -1]
    end
    
    def add(entity, x, y, direction = nil)
      @entities << entity
      entity.position = Position.new(self, x, y, direction)
    end
    
    def place_exit(x, y)
      @exit_location = [x, y]
    end
    
    def exit_space
      space(*@exit_location)
    end
    
    def entities
      @entities.reject { |u| u.position.nil? }
    end
    
    def other_entities
      entities.reject { |u| u.kind_of? Units::Survivor }
    end
    
    def get(x, y)
      entities.detect do |unit|
        unit.position.at?(x, y)
      end
    end
    
    def space(x, y)
      Space.new(self, x, y)
    end
    
    def out_of_bounds?(x, y)
      x < 0 || y < 0 || x > @width-1 || y > @height-1
    end
    
    def character
      rows = []
      rows << " " + ("-" * @width)
      @height.times do |y|
        row = "|"
        @width.times do |x|
          row << space(x, y).character
        end
        row << "|"
        rows << row
      end
      rows << " " + ("-" * @width)
      rows.join("\n") + "\n"
    end
    
    def unique_entities
      unique_entities = []
      entities.each do |entity|
        unique_entities << entity unless unique_entities.map { |u| u.class }.include?(entity.class)
      end
      unique_entities
    end
  end
end
