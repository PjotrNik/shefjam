extends Node

@export var max_health = 100
var current_health = max_health

signal health_depleted
signal damage_taken

func _ready():
	current_health = max_health
	
func damage(amount):
	current_health -= amount
	
	if(current_health <= 0):
		health_depleted.emit()

func _on_hitbox_area_entered(area):
	damage(10)
	damage_taken.emit()

func get_max_hp():
	return max_health

func get_hp():
	return current_health
	
func set_max_hp(hp):
	max_health = hp

func set_hp(hp):
	current_health = hp
