extends State
class_name Boss_Walk

@export var SPEED = 150
var player

func Exit():
	$"../..".current_speed = 0

func Enter():
	$"../..".current_speed = SPEED
	#get player location
	
	player = get_tree().get_first_node_in_group("Player")
	if player.position.x > $"../..".position.x:
		$"../..".direction = 1
	else:
		$"../..".direction = -1
	
func Update(_delta: float):
	print ("boss walk update")
	if player.position.x > $"../..".position.x:
		$"../..".direction = 1
	else:
		$"../..".direction = -1
	
func Physics_Update(_delta: float):
	pass
