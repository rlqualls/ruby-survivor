#  --------
# |@   s  >|
#  --------

description "It is too dark to see anything, but you smell a zombie nearby."
tip "Use survivor.feel.empty? to see if there is anything in front of you, and survivor.attack! to fight it. Remember, you can only do one action (ending in !) per turn."
clue "Add an if/else condition using survivor.feel.empty? to decide whether to survivor.attack! or survivor.walk!."

time_bonus 20
ace_score 26
size 8, 1
stairs 7, 0

survivor 0, 0, :east do |u|
  u.add_abilities :feel, :attack!
end

unit :zombie, 4, 0, :west
