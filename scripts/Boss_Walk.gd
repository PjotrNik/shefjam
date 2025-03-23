extends State
class_name Boss_Walk

@export var SPEED = 150
var player
var rng

func Exit():
	$"../..".current_speed = 0
	

func Enter():
	print("Walking")
	$"../..".change_sprites($"../..".get_phase(),"default")
	$"../..".current_speed = SPEED
	#Decide when to lob
	rng = RandomNumberGenerator.new()
	var time = rng.randf_range(1.25, 2.25)
	$lob_timer.start(time)
	
	#get player location
	player = get_tree().get_first_node_in_group("Player")
	if player.position.x > $"../..".position.x:
		$"../..".direction = 1
	else:
		$"../..".direction = -1
	
func Update(_delta: float):
	var player_x = player.position.x
	var player_y = player.position.y
	var player_x_distance = player_x - $"../..".position.x
	var player_y_distance = player_y - $"../..".position.y
	
	#Do attack, chance of slash or wave
	if (abs(player_x_distance) < 160):
		var chance = rng.randi_range(0,100)
		if  $"../..".phase == 0:
			print("TUTORIAL BOSS")
			$"../..".velocity.x = 0
		elif $"../..".phase == 2:
			var jump_chance = 40
			if player_y_distance < -300:
				jump_chance = 0
			if chance > 60:
				Transitioned.emit(self, "Boss_shockwave_phase2")
			elif chance > jump_chance:
				Transitioned.emit(self, "Boss_Platform_Jump")
			else:
				Transitioned.emit(self, "Boss_Slash")
		elif $"../..".phase == 1: 
			if chance > 40:
				Transitioned.emit(self, "Boss_Slash")
			else:
				Transitioned.emit(self, "Boss_Shockwave")
		else:
			#tutorial states here
			pass
	
	if player_x_distance > 0:
		$"../..".direction = 1
	else:
		$"../..".direction = -1
	
func Physics_Update(_delta: float):
	pass


func _on_lob_timer_timeout():
	if  $"../..".phase != 0:
		Transitioned.emit(self, "Boss_Lob")
