module RubySurvivor
  class Space
    def initialize(floor, x, y)
      @floor, @x, @y = floor, x, y
    end
    
    def wall?
      @floor.out_of_bounds? @x, @y
    end
    
    def survivor?
      thing.kind_of? Units::Survivor
    end
     
    def player?
      survivor?
    end
    
    def enemy?
      thing && !player? && !captive?
    end
    
    def captive?
      thing && thing.bound?
    end

    def item?
      medpack? || shotgun?
    end

    def medpack?
      thing.kind_of? Items::Medpack
    end

    def shotgun?
      thing.kind_of? Items::Shotgun
    end
    
    def empty?
      thing.nil? && !wall?
    end
    
    def exit?
      @floor.exit_location == location
    end
    
    def ticking?
      thing && thing.abilities.include?(:explode!)
    end
    
    def thing
      @floor.get(@x, @y)
    end
    
    def location
      [@x, @y]
    end
    
    def character
      if thing
        thing.character
      elsif exit?
        ">"
      else
        " "
      end
    end
    
    def to_s
      if thing
        thing.to_s
      elsif wall?
        'wall'
      else
        'nothing'
      end
    end
  end
end
