extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.modulate.a = 0.5
	$CollisionShape2D.set_deferred("disabled", true)

func turn_on():
	$CollisionShape2D.set_deferred("disabled", false)
	$Sprite2D.modulate.a = 1
