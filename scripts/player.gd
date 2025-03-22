extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -1000.0
const DASH_SPEED = 1000
const SHOTGUN_RECOIL = 500.0
const DEATH_VELOCITY = -500

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
@onready var body_collider: CollisionShape2D = $BodyCollider
@onready var death_timer: Timer = $DeathTimer
@onready var player_hit_box: Area2D = $PlayerHitBox
@onready var invun_timer: Timer = $InvunTimer

var is_dead = false
var has_landed = true
var dashing = false
var can_dash = true
var facing = 1

signal melee_cooldown_timer
signal shotgun_cooldown_timer
signal dash_cooldown_timer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not dashing:
		velocity += get_gravity() * delta * 2
		if not (is_animation_playing("dash") or is_animation_playing("hit")):
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
		velocity.y = 0

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
		dash_cooldown_timer.emit()
	# TODO dash is stopped when no direction is pressed
	if direction and not is_dead: 
		if dashing:
			player_hit_box.set_deferred("monitoring", false)
			velocity.x = current_dash_direction * DASH_SPEED
			velocity.y = 0
			if not (is_animation_playing("dash")):
				animated_sprite_2d.play("dash") 
				print("dash play")
		else:
			velocity.x = direction * SPEED
			if not (is_animation_playing("dash") or is_animation_playing("hit")):
				animated_sprite_2d.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not (is_animation_playing("hit") or is_animation_playing("death")):
			animated_sprite_2d.play("idle")
	
	# Flip player
	if direction < 0 and not is_dead:
		animated_sprite_2d.flip_h = true
		facing = -1
	elif direction > 0 and not is_dead:
		animated_sprite_2d.flip_h = false
		facing = 1
		
	# Attacks
	if Input.is_action_just_pressed("melee_attack") and not dashing and melee_cooldown.is_stopped():
		melee_collision.set_deferred("disabled", false)
		melee_animation.play("slash")
		melee_attack.set_collision_mask_value(2, true)
		print("MELEEEEEE!!!!!")
		melee_cooldown.start()
		melee_cooldown_timer.emit()
		
	elif Input.is_action_just_pressed("ranged_attack") and not dashing and shotgun_cooldown.is_stopped():
		velocity.x = (-direction) * SHOTGUN_RECOIL
		shotgun_particles.emitting = true
		shotgun_collision.set_deferred("disabled", false)
		shotgun_attack.set_collision_mask_value(2, true)
		print("SHOTGUNNNNN!!!!")
		shotgun_cooldown.start()
		shotgun_cooldown_timer.emit()
	else:
		shotgun_collision.set_deferred("disabled", true)
		melee_collision.set_deferred("disabled", true)
		melee_attack.set_collision_mask_value(2, false)
		shotgun_attack.set_collision_mask_value(2, false)
	
	shotgun_particles.direction.x = facing
	shotgun_particles.position.x *= facing
	melee_attack.scale.x = facing
	melee_attack.position.x *= facing
	shotgun_attack.scale.x = facing
	shotgun_attack.position.x *= facing

	move_and_slide()
	
func is_animation_playing(anim_name):
	return animated_sprite_2d.is_playing() and animated_sprite_2d.animation == anim_name
		
func _on_dash_timer_timeout() -> void:
	dashing = false
	dash_particles.emitting = false
	player_hit_box.set_deferred("monitoring", true)

func _on_dash_cooldown_timeout() -> void:
	can_dash = true

func _on_health_manager_damage_taken() -> void:
	print("TAKEN DAMAGAE!!!")
	if not (animated_sprite_2d.is_playing() and animated_sprite_2d.animation == "hit"):
		animated_sprite_2d.play("hit")
	invun_timer.start()
	player_hit_box.set_deferred("monitoring", false)

func _on_health_manager_health_depleted() -> void:
	if not is_dead:
		print("You died!")
		Engine.time_scale = 0.5
		
		velocity.y = DEATH_VELOCITY
		is_dead = true
		body_collider.set_deferred("disabled", true)
		animated_sprite_2d.play("death")
		death_timer.start()

func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene() # Temporary


func _on_invun_timer_timeout() -> void:
	player_hit_box.set_deferred("monitoring", true)
