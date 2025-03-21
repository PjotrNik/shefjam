extends State
class_name Boss_Walk

@export var SPEED = 300

func Exit():
	pass

func Enter():
	$"../..".current_speed = SPEED
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
