extends Area2D

func _on_PortalArea4_body_entered(body):
	get_tree().change_scene(Global.level4)
