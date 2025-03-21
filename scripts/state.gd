extends Node
class_name State
# put all states as child of state_machine

signal Transitioned

func Exit():
	pass

func Enter():
	pass
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
