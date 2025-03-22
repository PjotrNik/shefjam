extends State
class_name Boss_Shockwave

func Exit():
	pass

func Enter():
	$windup.start()
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
func _on_windup_timeout():
	pass # Replace with function body.
