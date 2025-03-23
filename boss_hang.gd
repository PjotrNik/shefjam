extends State
class_name Boss_Hang

@export var SPEED = 150
var player
var rng

func Exit():
	$"../..".current_speed = 0

func Enter():
	$"../..".change_sprites($"../..".get_phase(),"default")
	$"../..".current_speed = 0
	
	#get player location
	player = get_tree().get_first_node_in_group("Player")

func Update(_delta: float):
	rng = RandomNumberGenerator.new()
	var chance = rng.randf_range(0, 100)
	
	if chance > 60:
		Transitioned.emit(self, "Boss_eyes_phase3")
	elif chance > 20:
		Transitioned.emit(self, "Boss_water_phase3")
	else:
		Transitioned.emit(self, "Boss_fire_phase3")
	
func Physics_Update(_delta: float):
	pass
