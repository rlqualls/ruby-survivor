#  ------
# |>p Z @|
#  ------

description "You feel a wall right in front of you and an opening behind you."
tip "You are not as effective at attacking backward. Use survivor.feel.wall? and survivor.pivot! to turn around."

time_bonus 30
ace_score 50
size 6, 1
exit 0, 0

survivor 5, 0, :east do |u|
  u.add_abilities :walk!, :pivot!, :attack!, :run!, :swing!, :health, :look, :feel
end

unit :spitter, 1, 0, :east
unit :thick_zombie, 3, 0, :east
