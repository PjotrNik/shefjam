extends Node2D

var phase_1 = "res://scenes/phase_1_map.tscn"
@onready var player: CharacterBody2D = %Player

func _ready() -> void:
	print("SCENE TUTORIAL")

func _on_boss_phase_change(phase):
	print(phase)
	if phase == 1:
		get_tree().change_scene_to_file(phase_1)
		#var instance = phase_1.instantiate()
		#self.add_child(instance)
