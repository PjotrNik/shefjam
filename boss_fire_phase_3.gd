extends State
class_name Boss_fire_phase3
var fire = preload("res://scenes/slash_attack.tscn")
var warning = preload("res://scenes/fire_warning.tscn")
var rng
var order
var count = 0

func Exit():
	pass

func Enter():
	rng = RandomNumberGenerator.new()
	order = rng.randi_range(0,1)
	$windup.start()
	$"../..".change_sprites($"../..".get_phase(),"fire")
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
func _on_windup_timeout():
	$"../..".change_sprites($"../..".get_phase(),"attack")
	$warning_delay.start()
	
func _on_delay_timeout():
	Transitioned.emit(self, "Boss_Hang")

func _on_attack_delay_timeout():
	if order != 1:
		var y_ax = 245
		var warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(382, y_ax)
		warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(285, y_ax)
		warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(763, y_ax)
		warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(865, y_ax)
	else:
		var y_ax = 475
		var warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(168, y_ax)
		warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(298, y_ax)
		warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(969, y_ax)
		warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(429, y_ax)
		warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(565, y_ax)
		warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(700, y_ax)
		warn = fire.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(834, y_ax)
	
	$"../Boss_Slash/flames".play()
	if count == 1:
		$delay.start()
	else:
		count += 1
		order += 1
		$warning_delay.start()
	


func _on_warning_delay_timeout():
	
	$"../Boss_Slash/smoke".play()
	
	if order != 1:
		var y_ax = 245
		var warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(382, y_ax)
		warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(285, y_ax)
		warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(763, y_ax)
		warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(865, y_ax)
	else:
		var y_ax = 475
		var warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(168, y_ax)
		warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(298, y_ax)
		warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(969, y_ax)
		warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(429, y_ax)
		warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(565, y_ax)
		warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(700, y_ax)
		warn = warning.instantiate()
		get_tree().root.add_child(warn)
		warn.global_position = Vector2(834, y_ax)
		
	$attack_delay.start()
