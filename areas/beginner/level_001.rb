#  --------
# |@      >|
#  --------

description "You stand at the end of an empty alley.  It's 5AM, and at this point East Providence is just a couple of miles away.  Your daughter, Ruby, is hopefully still waiting for you there."

tip "Call survivor.walk! to walk forward in the Player 'play_turn' method."


time_bonus 15
ace_score 10
size 8, 1
exit 7, 0

survivor 0, 0, :east do |u|
  u.add_abilities :walk!
end
