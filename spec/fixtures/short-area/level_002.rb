#  --
# |@>|
#  --

description "You see before yourself a long hallway with stairs at the end. There is nothing in the way."
tip "Call survivor.walk! to walk forward in the Player 'play_turn' method."

time_bonus 15
ace_score 17
size 2, 1
exit 1, 0

survivor 0, 0, :east do |u|
  u.add_abilities :walk!
end
