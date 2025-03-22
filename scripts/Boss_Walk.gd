extends State
class_name Boss_Walk

@export var SPEED = 150
var player

func Exit():
	$"../..".current_speed = 0
	

func Enter():
	print("Walking")
	$"../..".current_speed = SPEED
	#Decide when to lob
	var rng = RandomNumberGenerator.new()
	var time = rng.randf_range(1.5, 3)
	$lob_timer.start(time)
	
	#get player location
	player = get_tree().get_first_node_in_group("Player")
	if player.position.x > $"../..".position.x:
		$"../..".direction = 1
	else:
		$"../..".direction = -1
	
func Update(_delta: float):
	var player_x = player.position.x
	var player_distance = player_x - $"../..".position.x
	
	if (abs(player_distance) < 80):
		Transitioned.emit(self, "Boss_Slash")
		
	
	if player_distance > 0:
		$"../..".direction = 1
	else:
		$"../..".direction = -1
	
func Physics_Update(_delta: float):
	pass


func _on_lob_timer_timeout():
	Transitioned.emit(self, "Boss_Lob")
