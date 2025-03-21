extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 1000

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown: Timer = $DashCooldown

var is_dead = false
var has_landed = true
var dashing = false
var can_dash = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not dashing:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, +1
	#get input direction and handle movement
	var direction = Input.get_axis("move_left", "move_right")
	var current_dash_direction = direction
	
	if Input.is_action_just_pressed("dash") and can_dash and direction != 0:
		dashing = true
		can_dash = false
		#current_dash_direction = direction
		$DashTimer.start()
		$DashCooldown.start()
	if direction and not is_dead: #TODO dash is stopped when no direction is pressed
		if dashing:
			play_animations("dash")
			velocity.x = current_dash_direction * DASH_SPEED
			velocity.y = 0
		else:
			velocity.x = direction * SPEED
			play_animations("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		play_animations("idle")
	
	# Flip player
	var flipped = false
	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false

	move_and_slide()
	
func play_animations(name: String) -> void:
	pass
	if is_on_floor():
		animated_sprite_2d.play(name)
	else:
		if dashing:
			animated_sprite_2d.play("Dash")
		else:
			animated_sprite_2d.play("jump")


func _on_dash_timer_timeout() -> void:
	dashing = false

func _on_dash_cooldown_timeout() -> void:
	can_dash = true
