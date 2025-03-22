extends Area2D

@export var target_pos : Vector2
@export var start_pos : Vector2
@export var projectile_speed : float
@export var top_arc_pos : Vector2
@export var gravity_force : Vector2
var t = 0

func _ready():
	start_pos = global_position
	top_arc_pos = Vector2((start_pos.x + (target_pos.x - start_pos.x) / 2 ), start_pos.y - 600)
	
func _physics_process(delta):
	t += delta * projectile_speed
	var q0 = start_pos.lerp(top_arc_pos, t)
	var q1 = top_arc_pos.lerp(target_pos, t)
	var r = q0.lerp(q1,t)
	global_position = r
		
func set_target(target: Vector2):
	target_pos = target

#func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#print("f")
	#if body is TileMapLayer:
		#if body.get_cetile_map_data().collision_layer == 3:
			#queue_free()
