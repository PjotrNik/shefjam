extends Node2D

func _ready():
	$TTL.start()

func _on_ttl_timeout():
	queue_free()
