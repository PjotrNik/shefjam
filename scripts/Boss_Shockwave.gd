extends State
class_name Boss_Shockwave
var slash = preload("res://scenes/slash_attack.tscn")
var wave = preload("res://scenes/shockwave.tscn")

func Exit():
	pass

func Enter():
	$windup.start()
	
	var player_distance = get_tree().get_first_node_in_group("Player").position.x - $"../..".position.x
	if player_distance > 0:
		$"../..".direction = 1
	else:
		$"../..".direction = -1
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
func _on_windup_timeout():
	var instance = slash.instantiate()
	var shock = wave.instantiate()
	if $"../..".direction == 1:
		$"../../Attack Slash".add_child(instance)
		$"../../Attack Slash".add_child(shock)
	else:
		$"../../Attack Slash Left".add_child(instance)
		shock.direction_right = false
		$"../../Attack Slash Left".add_child(shock)
	Transitioned.emit(self, "Boss_Walk")
	print ("Sending out shockwave")
