extends Node

@export var max_health = 100
var current_health

signal health_depleted
signal damage_taken

func _ready():
	current_health = max_health
	
func damage(amount):
	current_health -= amount
	
	if(current_health <= 0):
		health_depleted.emit()

func _on_hitbox_area_entered(area):
	damage(5)
	damage_taken.emit()
