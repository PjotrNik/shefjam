extends CharacterBody2D

@export var target_pos : Vector2
@export var start_pos : Vector2
@export var projectile_speed : float
@export var top_arc_pos : Vector2
@export var gravity_force : Vector2
var t = 0

func _ready():
	position = Vector2(0,400)
	start_pos = global_position
	top_arc_pos = Vector2(((target_pos.x - start_pos.x) / 2 ), start_pos.y - 600)
	pass
	
func _physics_process(delta):
	if t < 1:
		t += delta * projectile_speed
		var q0 = start_pos.lerp(top_arc_pos, t)
		var q1 = top_arc_pos.lerp(target_pos, t)
		var r = q0.lerp(q1,t)
		position = r
	
