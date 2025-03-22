extends State
class_name Boss_Walk

@export var SPEED = 150
var player
var rng

func Exit():
	$"../..".current_speed = 0
	

func Enter():
	print("Walking")
	$"../../AnimatedSprite2D".play("default")
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
	var player_distance = player_x - $"../..".position.x
	
	#Do attack, chance of slash or wave
	if (abs(player_distance) < 160):
		var chance = rng.randi_range(0,100)
		if  $"../..".phase == 0:
			print("TUTORIAL BOSS")
			# Do nothing 
		elif $"../..".phase == 2:
			if chance > 60:
				Transitioned.emit(self, "Boss_Slash")
			elif chance > 40:
				Transitioned.emit(self, "Boss_Platform_Jump")
			else:
				Transitioned.emit(self, "Boss_shockwave_phase2")
		elif $"../..".phase == 1: 
			if chance > 40:
				Transitioned.emit(self, "Boss_Slash")
			else:
				Transitioned.emit(self, "Boss_Shockwave")
		else:
			#tutorial states here
			pass
	
	if player_distance > 0:
		$"../..".direction = 1
	else:
		$"../..".direction = -1
	
func Physics_Update(_delta: float):
	pass


func _on_lob_timer_timeout():
	if  $"../..".phase != 0:
		Transitioned.emit(self, "Boss_Lob")
