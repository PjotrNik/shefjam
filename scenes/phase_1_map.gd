extends Node2D

var phase2_platforms = preload("res://scenes/phase_2_map.tscn")
@onready var player: CharacterBody2D = %Player

func _ready() -> void:
	print("PHASE 1")

func _on_boss_phase_change(phase):
	print(phase)
	if phase == 2:
		var instance = phase2_platforms.instantiate()
		instance.global_position = Vector2(0, -800)
		self.add_child(instance)
		var platforms = get_node("Platforms")
		var tween = create_tween()
		tween.tween_property(platforms, "position", Vector2(0,0), 1.3)
