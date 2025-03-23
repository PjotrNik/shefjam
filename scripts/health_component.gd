extends Node

@onready var boss = null
@onready var hit_sound: AudioStreamPlayer2D = %HitSound
@onready var death_sound: AudioStreamPlayer2D = %DeathSound

@export var max_health = 3
var current_health

signal health_depleted
signal damage_taken

func _ready():
	#current_health = max_health
	pass
	
func damage(amount):
	hit_sound.play()
	current_health -= amount
	
	if(current_health <= 0):
		death_sound.play()
		health_depleted.emit()

func _on_player_hit_box_area_entered(area: Area2D) -> void:
	damage(1)
	damage_taken.emit()
	
