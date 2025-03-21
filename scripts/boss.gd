extends CharacterBody2D

const JUMP_VELOCITY = -400.0

var current_speed = 0
var direction = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = current_speed * direction

	move_and_slide()
	
func set_speed(speed):
	current_speed = speed
