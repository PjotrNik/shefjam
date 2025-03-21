extends CharacterBody2D

@export var speed : float
@export var ttl : float
var direction_right = true

func _ready():
	$Timer.wait_time = ttl
	position = Vector2(0,400)
	if !direction_right:
		$AnimatedSprite2D.flip_h
	
func _physics_process(delta):
	if direction_right:
		global_position.x += speed * delta
	else:
		global_position.x -= speed * delta


func _on_timer_timeout():
	
