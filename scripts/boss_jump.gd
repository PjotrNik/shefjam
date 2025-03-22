extends State
class_name Boss_Jump

@export var target_pos : Vector2
var start_pos : Vector2
@export var speed : float
@export var top_arc_pos : Vector2
var t = 0

func Exit():
	pass
	
func Enter():
	start_pos = $"../..".global_position
	top_arc_pos = Vector2(((target_pos.x - start_pos.x) / 2 ), start_pos.y - 600)
	
func Update(_delta: float):
	pass
	
func Physics_Update(delta: float):
	if t < 1:
		t += delta * speed
		var q0 = start_pos.lerp(top_arc_pos, t)
		var q1 = top_arc_pos.lerp(target_pos, t)
		var r = q0.lerp(q1,t)
		$"../..".position = r
	
