extends Area2D

func _on_SpeedBootsPickup_body_entered(body):
	if body == Global.Player:
		var speed_boots = Global.speed_boots.instance()
		Global.Player.add_child(speed_boots)
		Global.Player.unlock_object_anim(Global.speed_boots_texture)
		get_node("/root/Level3/dialogue_system").area3_after_maze_interation("optionA")
		queue_free()
