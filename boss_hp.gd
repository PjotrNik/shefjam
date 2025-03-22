extends Control

var max_hp : float = 100
var hp : float = max_hp

func _ready():
	max_hp = $"../Boss/HealthManager".get_max_hp()
	hp = $"../Boss/HealthManager".get_hp()

func _process(delta):
	#$HPBar/Health.scale.x = hp / max_hp
	$Container/Health.scale.x = $"../Boss/HealthManager".get_hp() / max_hp
