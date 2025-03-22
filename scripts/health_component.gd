extends Node

@export var max_health = 100
var current_health

signal health_depleted

func _ready():
	current_health = max_health
	
func damage(amount):
	current_health -= amount
	
	if(current_health <= 0):
		health_depleted.emit()
