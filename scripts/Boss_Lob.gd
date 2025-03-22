extends State
class_name Boss_Lob
var lob_projectile = preload("res://projectile_1.tscn")

func Exit():
	pass

func Enter():
	$windup.start()
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	

#before lob
func _on_windup_timeout():
	var player = get_tree().get_first_node_in_group("Player")
	var instance = lob_projectile.instantiate()
	instance.set_target(player.global_position)
	$"../..".add_child.call_deferred(instance)
	instance.set_target(player.global_position)
	print ("lob attack")
	$delay.start()

#after lob
func _on_delay_timeout():
	Transitioned.emit(self, "Boss_Walk")
