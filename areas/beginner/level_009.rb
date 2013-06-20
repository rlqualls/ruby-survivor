#  -----------
# |>Cp  @ Z wC|
#  -----------

description "Time to hone your skills and apply all of the abilities that you have learned."
tip "Watch your back."
clue "Don't just keep shooting while you are being attacked from behind."

time_bonus 40
ace_score 100
size 11, 1
exit 0, 0

survivor 5, 0, :east

unit :captive, 1, 0, :east
unit :spitter, 2, 0, :east
unit :thick_zombie, 7, 0, :west
unit :witch, 9, 0, :west
unit :captive, 10, 0, :west
