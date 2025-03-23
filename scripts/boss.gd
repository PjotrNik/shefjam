extends CharacterBody2D

const JUMP_VELOCITY = -400.0

var current_speed = 0
var direction = 0
var base_sprite_modulate : Color
var phase = 3
var flash_count = 0
var floating = false

signal phase_change(phase)

func _ready():
	base_sprite_modulate = $AnimatedSprite2D.modulate

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and not floating:
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

func phase_transition(phase):
	$PhaseFlashTimer.start(0.2)

func _on_health_manager_health_depleted():
	if phase == 3:
		get_tree().change_scene_to_file("res://scenes/end_UI.tscn")
	phase_transition(phase)
	flash_count = 0
	phase += 1
	phase_change.emit(phase)
	$HealthManager.current_health = $HealthManager.max_health

func _on_timer_timeout():
	$AnimatedSprite2D.modulate = base_sprite_modulate

func _on_phase_flash_timer_timeout():
	flash_count += 1
	if flash_count < 7:
		if flash_count % 2 == 0:
			$AnimatedSprite2D.modulate = base_sprite_modulate
		else:
			$AnimatedSprite2D.modulate = Color(255,255,255)
	if flash_count == 6:
		#$AnimatedSprite2D = $AnimatedSprite2D
		pass
	$PhaseFlashTimer.start(0.2)
	
func set_phase(phase1):
	phase = phase1
	
func get_phase():
	return phase

func change_sprites(phase1, option):
	if phase == 2:
		if option == "fire":
			$AnimatedSprite2D.play("p2_fire")
		if option == "water":
			$AnimatedSprite2D.play("p2_water")
		if option == "root":
			$AnimatedSprite2D.play("p2_root")
		if option == "eye":
			$AnimatedSprite2D.play("p2_eye")
		if option == "default":
			$AnimatedSprite2D.play("p2_default")
		if option == "attack":
			$AnimatedSprite2D.play("p2_attack")
	else:
		if option == "fire":
			$AnimatedSprite2D.play("windup")
		if option == "water":
			$AnimatedSprite2D.play("windup_shock")
		if option == "root":
			$AnimatedSprite2D.play("windup_roots")
		if option == "eye":
			$AnimatedSprite2D.play("windup_lob")
		if option == "default":
			$AnimatedSprite2D.play("default")
		if option == "attack":
			$AnimatedSprite2D.play("attack_slash")
			
		
		
