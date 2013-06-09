Gem::Specification.new do |s|
  s.name        = "rubysurvivor"
  s.version     = "0.0.0"
  s.author      = "Robert Qualls"
  s.email       = "robert@robertqualls.com"
  s.homepage    = "https://github.com/rlqualls/ruby-survivor"
  s.summary     = "Game based on ruby-warrior for learning Ruby and artificial intelligence."
  s.description = "You program the AI of a survivor of a zombie apocalypse"

  s.files        = Dir["{lib,spec,features,towers,templates,bin}/**/*", "[A-Z]*", "init.rb"]
  s.require_path = "lib"
  s.executables  = ["rubysurvivor"]

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end
