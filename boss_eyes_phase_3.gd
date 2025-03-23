extends State
class_name Boss_Eye_Phase3
var lob_projectile = preload("res://scenes/projectile_1.tscn")
var rng
var count = 0

func Exit():
	count = 0

func Enter():
	$windup.start()
	$"../..".change_sprites($"../..".get_phase(),"eye")
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	

#before lob
func _on_windup_timeout():
	$attack_delay.start()
	$"../..".change_sprites($"../..".get_phase(),"attack")

#after lob
func _on_delay_timeout():
	Transitioned.emit(self, "Boss_Hang")

func _on_attack_delay_timeout():
	if count < 8:
		count += 1
		var instance = lob_projectile.instantiate()
		$eye.play()
		rng = RandomNumberGenerator.new()
		
		var target_x = rng.randi_range(-300,1400)
		instance.target_pos = Vector2(target_x, $"../..".global_position.y)
		
		var peak_x = $"../..".global_position.x + (target_x - $"../..".global_position.x) / 2
		var peak_y = rng.randi_range(500,1000)
		instance.top_arc_pos = Vector2(peak_x,peak_y)
		$"../..".add_child.call_deferred(instance)
		$attack_delay.start()
	else:
		$delay.start()
