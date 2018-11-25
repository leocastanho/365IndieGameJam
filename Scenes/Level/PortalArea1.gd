extends Area2D

func _on_PortalArea1_body_entered(body):
	get_tree().change_scene(Global.level1)
