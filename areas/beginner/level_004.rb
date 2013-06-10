#  -------
# |@    p>|
#  -------

description "You can hear a high-pitched hiss in the distance."

tip "Spitters can deal a lot of damage.  Instead of using survivor.walk!, use survivor.run! to get to them before they can take you down."

clue "Use survivor.run! to make it to enemies that can attack you from a distance"

time_bonus 45
ace_score 90
size 7, 1
exit 6, 0

survivor 0, 0, :east do |u|
  u.add_abilities :run!
end

unit :spitter, 5, 0, :west
