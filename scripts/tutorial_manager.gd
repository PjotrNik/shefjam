extends Node

@onready var player: CharacterBody2D = %Player
@onready var tutor_label: RichTextLabel = %TutorLabel
@onready var text_delay: Timer = %TextDelay
@onready var boss_spawn: Marker2D = $"../BossSpawn"

var boss = preload("res://boss.tscn")
var boss_hp = preload("res://scripts/boss_hp_bar.tscn")

var tutorials = [
	"Welcome to hell.",
	"Use the ARROW KEYS to move.",
	"Practice using your abilites.",
	"Lets do some target practice.",
	"Don't get too close!",
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await display_text(tutorials[0])
	await display_text(tutorials[1])
	await display_text(tutorials[2])
	await display_text(tutorials[3])
	var boss_instance = boss.instantiate()
	boss_instance.phase_change.connect(_on_boss_phase_change)
	var boss_hp_instance = boss_hp.instantiate()
	boss_instance.set_phase(0)
	boss_instance.global_position = boss_spawn.global_position
	#boss_instance.get_child_by_name("HealthManager").set_max_hp(30)
	boss_hp_instance.set("size", Vector2(1152, 648)) 
	boss_hp_instance.global_position = Vector2(0,0)
	
	get_parent().add_child(boss_instance)
	get_parent().add_child(boss_hp_instance)
	
	await display_text(tutorials[4])
	
	await get_tree().create_timer(5).timeout
	tutor_label.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func display_text(text: String) -> void:
	tutor_label.text = text
	tutor_label.visible_characters = 0
	var tween = create_tween()
	var character_speed = tutor_label.get_total_character_count() * 0.05
	tween.tween_property(tutor_label, "visible_characters", 
		tutor_label.get_total_character_count(), character_speed)
	await tween.finished
	await get_tree().create_timer(3).timeout
	print("FINISHED")

func _on_boss_phase_change(phase):
	if phase == 1:
		get_tree().change_scene_to_file("res://scenes/phase_1_map.tscn")
