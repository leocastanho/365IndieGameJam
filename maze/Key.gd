extends Area2D

func _on_Key_body_entered(body):
	if body == Global.Player:
		Global.key_count += 1
		Global.Player.unlock_object_anim(Global.key_texture)
		queue_free()
