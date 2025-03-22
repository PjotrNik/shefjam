extends Node2D

var phase2_platforms = preload("res://scenes/phase_2_map.tscn")

func _on_boss_phase_change(phase):
	print(phase)
	if phase == 2:
		var instance = phase2_platforms.instantiate()
		self.add_child(instance)
