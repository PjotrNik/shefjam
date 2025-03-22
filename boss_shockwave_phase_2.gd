extends State
class_name Boss_Shockwave_Phase2
var slash = preload("res://scenes/slash_attack.tscn")
var wave = preload("res://scenes/shockwave.tscn")

func Exit():
	pass

func Enter():
	print ("Sending out shockwave")
	$windup.start()
	$"../../AnimatedSprite2D".play("windup_shock")
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
func _on_windup_timeout():
	
	var player_distance = get_tree().get_first_node_in_group("Player").position.x - $"../..".position.x
	if player_distance > 0:
		$"../..".direction = 1
	else:
		$"../..".direction = -1
		
	for i in range(1,3):
		var instance = slash.instantiate()
		var shock = wave.instantiate()
		shock.set_start_pos($"../../shockwave".global_position)
		get_tree().root.add_child(shock)
		if $"../..".direction == -1:
			shock.direction_right = false
		else:
			shock.direction_right = true
		$"../..".direction = $"../..".direction * -1
		
	$"../../AnimatedSprite2D".play("attack_slash")
	$delay.start()
	
func _on_delay_timeout():
	Transitioned.emit(self, "Boss_Walk")
