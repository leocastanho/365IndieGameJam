extends Area2D

func _ready():
#	connect("body_entered", get_node("../../Level/dialogue_system"), "_on_DialogueTrigger_body_entered")
	pass

func _on_DialogueTrigger_body_entered(body):
	if body == Global.Player:
		queue_free()
