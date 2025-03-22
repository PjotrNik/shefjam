extends HBoxContainer

@onready var shotgun_icon: TextureRect = $"ShotgunIcon"
@onready var cooldown_bar: TextureProgressBar = $"ShotgunIcon/ShotgunCooldown"
@onready var timer: Timer = $"ShotgunIcon/Timer"

@export var cooldown = 6.0
var disabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_nodes_in_group("Player")[0]
	timer = player.get_node("ShotgunAttack/ShotgunCooldown")
	player.connect("shotgun_cooldown_timer", _on_shotgun_cooldown_timer)
	timer.wait_time = cooldown
	cooldown_bar.value = 0
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown_bar.value = int((timer.time_left / cooldown) * 100)
	
func _on_timer_timeout():
	print("ability ready")
	cooldown_bar.value = 0
	disabled = true
	set_process(false)

func _on_shotgun_cooldown_timer():
	print("hello")
	disabled = true
	set_process(true)
	timer.start()
	
