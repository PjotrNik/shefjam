extends Node

@export var max_health = 3
var current_health

signal health_depleted
signal damage_taken

func _ready():
	current_health = max_health
	
func damage(amount):
	current_health -= amount
	
	if(current_health <= 0):
		health_depleted.emit()

func _on_player_hit_box_area_entered(area: Area2D) -> void:
	damage(1)
	damage_taken.emit()
	
