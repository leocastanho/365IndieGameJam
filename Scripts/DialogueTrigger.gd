extends Area2D

func _on_DialogueTrigger_body_entered(body):
	if body == Global.Player:
		queue_free()
