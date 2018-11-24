extends Area2D

func _on_LightOff_body_entered(body):
	if Global.lightON:
		Global.Player.get_node("CanvasModulate/AnimationPlayer").play("lights_off")
		Global.lightON = false
