#  -------
# |@ CppS>|
#  -------

description "You hear cries for help. Captives must need rescuing."

tip "Use survivor.feel.captive? to see if there is a captive and survivor.rescue! to rescue him. Don't attack captives."

time_bonus 45
ace_score 123
size 7, 1
exit 6, 0

survivor 0, 0, :east do |u|
  u.add_abilities :rescue!
end

unit :captive, 2, 0, :west
unit :spitter, 3, 0, :west
unit :spitter, 4, 0, :west
unit :thick_zombie, 5, 0, :west
