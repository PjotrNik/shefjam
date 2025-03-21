extends State
class_name Boss_Slash
var slash = preload("res://slash_attack.tscn")

func Exit():
	pass

func Enter():
	var instance = slash.instantiate()
	print(instance.position)
	instance.global_position = $"../../Attack Slash".global_position
	print(instance.position)
	add_child(instance)
	
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
