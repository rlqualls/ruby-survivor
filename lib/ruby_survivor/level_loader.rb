module RubySurvivor
  class LevelLoader
    def initialize(level)
      @floor = RubySurvivor::Floor.new
      @level = level
      @level.floor = @floor
    end
    
    def description(desc)
      @level.description = desc
    end
    
    def tip(tip)
      @level.tip = tip
    end
    
    def clue(clue)
      @level.clue = clue
    end
    
    def time_bonus(bonus)
      @level.time_bonus = bonus
    end
    
    def ace_score(score)
      @level.ace_score = score
    end
    
    def size(width, height)
      @floor.width = width
      @floor.height = height
    end
    
    def exit(x, y)
      @floor.place_exit(x, y)
    end
    
    def unit(unit, x, y, facing = :north)
      unit = unit_to_constant(unit).new unless unit.kind_of? Units::Base
      @floor.add(unit, x, y, facing)
      yield unit if block_given?
      unit
    end

    def item(item, x, y)
      item = item_to_constant(item).new unless item.kind_of? Items::Base
      @floor.add(item, x, y, nil)
      yield item if block_given?
      item
    end
    
    def survivor(*args, &block)
      @level.setup_survivor unit(Units::Survivor.new, *args, &block)
    end
    
    private
    
    def unit_to_constant(name)
      camel = name.to_s.split('_').map { |s| s.capitalize }.join
      eval("Units::#{camel}")
    end

    def item_to_constant(name)
      camel = name.to_s.split('_').map { |s| s.capitalize }.join
      eval("Items::#{camel}")
    end
  end
end
