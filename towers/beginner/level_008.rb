#  -------
# |@  Cww>|
#  -------

description "You hear the groaning of witches. Beware of their deadly screams! Good thing you found a shotgun."
tip "Use survivor.look to determine your surroundings, and survivor.shoot! to fire your gun."
clue "Witches are deadly but low in health. Kill them before they have time to attack."

time_bonus 20
ace_score 46
size 6, 1
exit 5, 0

survivor 0, 0, :east do |u|
  u.add_abilities :look
  u.add_abilities :shoot!
end

unit :captive, 2, 0, :west
unit :witch, 3, 0, :west
unit :witch, 4, 0, :west
