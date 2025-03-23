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
		
