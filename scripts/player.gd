extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -1000.0
const DASH_SPEED = 1000
const SHOTGUN_RECOIL = 500.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown: Timer = $DashCooldown
@onready var dash_particles: CPUParticles2D = $DashParticles
@onready var dust_scene = preload("res://scenes/dust.tscn")
@onready var marker_2d: Marker2D = $Marker2D
@onready var shotgun_particles: CPUParticles2D = $ShotgunParticles
@onready var shotgun_collision: CollisionShape2D = $ShotgunAttack/ShotgunCollision
@onready var shotgun_attack: Area2D = $ShotgunAttack
@onready var melee_collision: CollisionShape2D = $MeleeAttack/MeleeCollision
@onready var melee_animation: AnimatedSprite2D = $MeleeAttack/MeleeAnimation
@onready var melee_attack: Area2D = $MeleeAttack
@onready var melee_cooldown: Timer = $MeleeAttack/MeleeCooldown
@onready var shotgun_cooldown: Timer = $ShotgunAttack/ShotgunCooldown

var is_dead = false
var has_landed = true
var dashing = false
var can_dash = true
var flipped = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not dashing:
		velocity += get_gravity() * delta * 2
		if not (animated_sprite_2d.is_playing() and (animated_sprite_2d.animation == "dash" or animated_sprite_2d.animation == "hit")):
			animated_sprite_2d.play("jump")
		
	if not has_landed and is_on_floor():
		var dust_instance = dust_scene.instantiate()
		dust_instance.scale *= 1.62
		dust_instance.global_position = marker_2d.global_position
		get_parent().add_child(dust_instance)

	has_landed = is_on_floor()
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif velocity.y <= 0 and Input.is_action_just_released("jump"):
		velocity.y = -100

	# Get the input direction: -1, 0, +1
	var direction = Input.get_axis("move_left", "move_right")
	dash_particles.direction.x = -direction
	var current_dash_direction = direction
	
	# Dashing and movement
	if Input.is_action_just_pressed("dash") and can_dash and direction != 0:
		dashing = true
		can_dash = false
		dash_particles.emitting = true
		dash_timer.start()
		dash_cooldown.start()
	if direction and not is_dead: #TODO dash is stopped when no direction is pressed
		if dashing:
			velocity.x = current_dash_direction * DASH_SPEED
			velocity.y = 0
			if not (animated_sprite_2d.is_playing() and animated_sprite_2d.animation == "dash"):
				animated_sprite_2d.play("dash") 
				print("dash play")
		else:
			velocity.x = direction * SPEED
			if not (animated_sprite_2d.is_playing() and (animated_sprite_2d.animation == "dash" or animated_sprite_2d.animation == "hit")): 
				animated_sprite_2d.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not (animated_sprite_2d.is_playing() and animated_sprite_2d.animation == "hit"):
			animated_sprite_2d.play("idle")
	
	# Flip player
	if direction < 0:
		animated_sprite_2d.flip_h = true
		flipped = -1
	elif direction > 0:
		animated_sprite_2d.flip_h = false
		flipped = 1
		
	# Attacks
	if Input.is_action_just_pressed("melee_attack") and not dashing and melee_cooldown.is_stopped():
		melee_collision.set_deferred("disabled", false)
		melee_animation.play("slash")
		melee_attack.set_collision_mask_value(2, true)
		print("MELEEEEEE!!!!!")
		melee_cooldown.start()
		
	elif Input.is_action_just_pressed("ranged_attack") and not dashing and shotgun_cooldown.is_stopped():
		velocity.x = (-direction) * SHOTGUN_RECOIL
		shotgun_particles.emitting = true
		shotgun_collision.set_deferred("disabled", false)
		shotgun_attack.set_collision_mask_value(2, true)
		print("SHOTGUNNNNN!!!!")
		shotgun_cooldown.start()
	else:
		shotgun_collision.disabled = true
		melee_collision.disabled = true
		shotgun_collision.set_deferred("disabled", true)
		melee_collision.set_deferred("disabled", true)
		melee_attack.set_collision_mask_value(2, false)
		shotgun_attack.set_collision_mask_value(2, false)
		
	shotgun_particles.direction.x = direction
	shotgun_particles.position.x *= direction
	melee_attack.scale.x = direction
	melee_attack.position.x *= direction
	shotgun_attack.scale.x = direction
	shotgun_attack.position.x *= direction

	move_and_slide()

func _on_dash_timer_timeout() -> void:
	dashing = false
	dash_particles.emitting = false

func _on_dash_cooldown_timeout() -> void:
	can_dash = true

func _on_health_manager_damage_taken() -> void:
	print("TAKEN DAMAGAE!!!")
	if not (animated_sprite_2d.is_playing() and animated_sprite_2d.animation == "hit"):
		animated_sprite_2d.play("hit")

func _on_health_manager_health_depleted() -> void:
	print("OH NO YOU DIED!!!!!")
