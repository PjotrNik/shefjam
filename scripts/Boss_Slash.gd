extends State
class_name Boss_Slash
var slash = preload("res://scenes/slash_attack.tscn")

func Exit():
	pass

func Enter():
	print ("Sending out attack")
	$"../../AnimatedSprite2D".play("windup")
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
	if $"../..".direction == 1:
		$"../../Attack Slash".add_child(instance)
	else:
		$"../../Attack Slash Left".add_child(instance)
		
	$"../../AnimatedSprite2D".play("default")
	Transitioned.emit(self, "Boss_Walk")
	
