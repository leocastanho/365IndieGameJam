extends Area2D

func _on_PortalArea1_body_entered(body):
	if not Global.love_stone_unlocked:
		Global.player_position = Vector2(position)
		Global.begin_anim_once = true
		get_tree().change_scene(Global.level1dialogue)