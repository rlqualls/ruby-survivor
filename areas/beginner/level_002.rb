#  --------
# |@   z  >|
#  --------

description "You start to make your way down the alley towards Newport Avenue until a soft groan stops you in your tracks.  It's coming from ahead. Definitely not a person - you can smell it. You start to pat around for your pistol only to remember how you dropped it back in Attleboro. Damn.  Reluctantly, you grab your KA-BAR."

tip "Use survivor.feel.empty? to see if there is anything in front of you, and survivor.attack! to fight it. Remember, you can only do one action (ending in !) per turn."

clue "Add an if/else condition using survivor.feel.empty? to decide whether to survivor.attack! or survivor.walk!."

time_bonus 20
ace_score 26
size 8, 1
exit 7, 0

survivor 0, 0, :east do |u|
  u.add_abilities :feel, :attack!
end

unit :zombie, 4, 0, :west
