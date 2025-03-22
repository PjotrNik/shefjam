extends Control
 
@onready var player: CharacterBody2D = %Player
@onready var h_box_container: HBoxContainer = $HBoxContainer

var normal_heart_path = "res://Sprites/Full_Hp.png"
var empty_heart_path = "res://Sprites/Empty_Hp.png"

var player_health = 0
var health_manager = null
var hearts = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts = [
		h_box_container.get_child(0), 
		h_box_container.get_child(1),  
		h_box_container.get_child(2)
	]
	health_manager = player.get_node("HealthManager")
	health_manager.connect("damage_taken", _on_damage_taken)
	player_health = health_manager.current_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player_health)
	
func _on_damage_taken() -> void:
	player_health -= 1
	var current_heart = hearts[player_health]
	current_heart.texture = load(empty_heart_path)
	
