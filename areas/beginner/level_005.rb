#  -------
# |@  ppZ>|
#  -------

description "You managed to find a baseball bat in the parking lot. It's not long after entering the hospital that you realize you will need to use it."

tip "Use survivor.swing! to do more damage.  Be warned, though, it will fatigue you more quickly."

time_bonus 45
ace_score 123
size 7, 1
exit 6, 0

survivor 0, 0, :east do |u|
  u.add_abilities :swing!
end

unit :spitter, 3, 0, :west
unit :spitter, 4, 0, :west
unit :thick_zombie, 5, 0, :west
