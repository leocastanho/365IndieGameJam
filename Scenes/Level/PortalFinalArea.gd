extends Area2D

var canEnter = false

func _on_PortalFinalArea_body_entered(body):
	if(canEnter):
		get_tree().change_scene("res://Scenes/Level/BossFinal/LevelBossFinal.tscn")
	
	pass # replace with function body


func _on_Timer_timeout():
	canEnter = true
	
	pass # replace with function body
