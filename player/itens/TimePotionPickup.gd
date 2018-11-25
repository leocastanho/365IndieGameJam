extends Area2D

func _on_TimePotionPickup_body_entered(body):
	if body == Global.Player:
		var time_potion = Global.time_potion.instance()
		Global.Player.add_child(time_potion)
		Global.Player.unlock_object_anim(Global.time_potion_texture)
		get_node("/root/Level3/dialogue_system").area3_after_maze_interation("optionB")
		Global.time_potion_unlock = true
		queue_free()