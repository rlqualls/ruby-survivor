#  ---------
# |@ s ss s>|
#  ---------

description "The air feels thicker than before. There must be a horde of zombies."
tip "Be careful not to die! Use survivor.health to keep an eye on your health, and survivor.rest! to earn 10% of max health back."
clue "When there is no enemy ahead of you call survivor.rest! until health is full before walking forward."

time_bonus 35
ace_score 71
size 9, 1
stairs 8, 0

survivor 0, 0, :east do |u|
  u.add_abilities :health, :rest!
end

unit :zombie, 2, 0, :west
unit :zombie, 4, 0, :west
unit :zombie, 5, 0, :west
unit :zombie, 7, 0, :west
