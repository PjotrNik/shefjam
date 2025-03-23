extends State
class_name Boss_water_phase3
var wave = preload("res://scenes/shockwave.tscn")
var rng
var count = 0

func Exit():
	count = 0

func Enter():
	$windup.start()
	$"../..".change_sprites($"../..".get_phase(),"water")
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
func _on_windup_timeout():
	$"../..".change_sprites($"../..".get_phase(),"attack")
	$attack_delay.start()
	
func _on_delay_timeout():
	Transitioned.emit(self, "Boss_Hang")

func _on_attack_delay_timeout():
	if count < 8:
		count += 1
			
		var wave = wave.instantiate()
		var start_pos : Vector2
		
		if count % 2 == 0:
			start_pos.x = 1000
			wave.direction_right = false
		else:
			start_pos.x = 150
			wave.direction_right = true
			
		rng = RandomNumberGenerator.new()
		start_pos.y = rng.randi_range(150,500)
		wave.set_start_pos(start_pos)
		
		
		get_tree().root.add_child(wave)
			
		$attack_delay.start()
	else:
		$delay.start()
