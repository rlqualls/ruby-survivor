#  ---------
# |@ z zz  >|
#  ---------

description "You start heading down Newport and notice them almost immediately - there must be a whole horde. You knew things would be bad in Pawtucket, but not this bad.  Without moving too quickly, you gently set your backpack down and unzip it. You're down to your last first aid kit. And you're going to need it."

tip "Be careful not to die! Use survivor.health to keep an eye on your health, and survivor.heal! to earn 50% of max health back if you are carrying a medpack."

time_bonus 35
ace_score 71
size 9, 1
exit 8, 0

survivor 0, 0, :east do |u|
  u.add_abilities :health, :heal!
end

unit :zombie, 2, 0, :west
unit :zombie, 4, 0, :west
unit :zombie, 5, 0, :west
