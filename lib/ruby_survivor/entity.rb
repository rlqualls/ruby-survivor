module RubySurvivor
  class Entity
    attr_writer :health
    attr_accessor :position
      
    def max_health
      0
    end
    
    def earn_points(points)
    end
    
    def health
      @health ||= max_health
    end
    
    def take_damage(amount)
      if health
        self.health -= amount
        say "takes #{amount} damage, #{health} health power left"
        if health <= 0
          @position = nil
          say "is destroyed"
        end
      end
    end

    def remove
      @position = nil
    end
    
    def alive?
      !@position.nil?
    end
      
    def say(msg)
      UI.puts_with_delay "#{name} #{msg}"
    end
    
    def name
      self.class.name.split('::').last.titleize
    end
    alias_method :to_s, :name
    
    def add_abilities(*new_abilities)
      new_abilities.each do |ability|
        abilities[ability] = eval("Abilities::#{ability.to_s.sub('!', '').camelize}").new(self) # TODO use something similar to constantize here
      end
    end
    
    def next_turn
      Turn.new(abilities)
    end
    
    def prepare_turn
      @current_turn = next_turn
      play_turn(@current_turn)
    end
    
    def perform_turn
      if @position
        abilities.values.each do |ability|
          ability.pass_turn
        end
        if @current_turn.action 
          name, *args = @current_turn.action
          abilities[name].perform(*args)
        end
      end
    end
    
    def play_turn(turn)
      # to be overriden by subclass
    end
    
    def abilities
      @abilities ||= {}
    end
    
    def character
      "?"
    end
  end
end
