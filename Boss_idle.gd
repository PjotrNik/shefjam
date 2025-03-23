extends State
class_name Boss_Idle
var roots = preload("res://scenes/roots.tscn")

func Exit():
	pass

func Enter():
	pass
	
func Update(_delta: float):
	$WaitTime.start
	
func Physics_Update(_delta: float):
	pass

func _on_wait_time_timeout():
	Transitioned.emit(self, "Boss_Walk")
