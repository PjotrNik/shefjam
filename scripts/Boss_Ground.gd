extends State
class_name Boss_Ground
var roots = preload("res://scenes/roots.tscn")

func Exit():
	pass

func Enter():
	print ("About to spawn roots")
	$"../../AnimatedSprite2D".play("windup_roots")
	$windup.start()
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	

#We do things here
func _on_windup_timeout():
	print ("roots spawning")
	for x in range(30): 
		print("spawned roots")
		var instance = roots.instantiate()
		add_child(instance)
		instance.global_position.x = 128 + (x * 32)
		instance.global_position.y = 512
		
	$delay.start()


func _on_delay_timeout():
	print("Clearing Roots")
	var all_roots = get_tree().get_nodes_in_group("root")
	for root in all_roots:
		root.queue_free()
		print("root cleared")
		
	Transitioned.emit(self, "boss_lob")
