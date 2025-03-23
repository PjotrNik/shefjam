extends State
class_name Move_to_centre

@export var target_pos : Vector2
var start_pos : Vector2
@export var speed : float
@export var top_arc_pos : Vector2
var t = 0

func Exit():
	t = 0
	
func Enter():
	$whispers.play()
	start_pos = $"../..".global_position
	target_pos = Vector2(576,50)
	top_arc_pos = Vector2((start_pos.x + (target_pos.x - start_pos.x) / 2 ), 700)
	
func Update(_delta: float):
	pass
	
func Physics_Update(delta: float):
	if t < 1:
		print(t)
		t += delta * speed
		var q0 = start_pos.lerp(top_arc_pos, t)
		var q1 = top_arc_pos.lerp(target_pos, t)
		var r = q0.lerp(q1,t)
		$"../..".global_position = r
	else:
		Transitioned.emit(self, "Boss_Hang")
	
