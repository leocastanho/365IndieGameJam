extends Area2D

func _on_PortalArea2_body_entered(body):
	get_tree().change_scene(Global.level2)
