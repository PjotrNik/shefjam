extends State
class_name Boss_water_phase3
var wave = preload("res://scenes/shockwave.tscn")
var portal = preload("res://scenes/water_portal.tscn")
var rng
var count = 0
var start_pos : Vector2

func Exit():
	pass

func Enter():
	$windup.start()
	$"../..".change_sprites($"../..".get_phase(),"water")
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
func _on_windup_timeout():
	$"../..".change_sprites($"../..".get_phase(),"attack")
	$portal_delay.start()
	
func _on_delay_timeout():
	Transitioned.emit(self, "Boss_Hang")

func _on_attack_delay_timeout():
	var wave = wave.instantiate()
		
	if count % 2 == 0:
		wave.direction_right = false
	else:
		wave.direction_right = true
		
	wave.set_start_pos(start_pos)
		
	get_tree().root.add_child(wave)
		
	$portal_delay.start()
	if count > 7:
		$delay.start()


func _on_portal_delay_timeout():
	if count < 8:
		count += 1
		start_pos
		
		rng = RandomNumberGenerator.new()
		start_pos.y = rng.randi_range(250,500)
		
		if count % 2 == 0:
			start_pos.x = 1000
		else:
			start_pos.x = 150
		
		var instance = portal.instantiate()
		instance.global_position = start_pos
		get_tree().root.add_child(instance)
		
		$attack_delay.start()
	else:
		$delay.start()
