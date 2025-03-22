extends CharacterBody2D

const JUMP_VELOCITY = -400.0

var current_speed = 0
var direction = 0
var base_sprite_modulate : Color
var phase = 0

signal phase_change(phase)

func _ready():
	base_sprite_modulate = $AnimatedSprite2D.modulate

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = current_speed * direction
	
	if (direction > 0):
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

	move_and_slide()
	
func set_speed(speed):
	current_speed = speed

func _on_health_manager_damage_taken():
	$AnimatedSprite2D.modulate = Color(255,0,0)
	$HealthManager/FlashTimer.start(0.1)

func _on_health_manager_health_depleted():
	if phase == 2:
		queue_free()
	phase += 1
	phase_change.emit(phase)
	$HealthManager.current_health = $HealthManager.max_health


func _on_timer_timeout():
	$AnimatedSprite2D.modulate = base_sprite_modulate
