extends Area2D

func _on_PortalArea3_body_entered(body):
	get_tree().change_scene(Global.level3)
