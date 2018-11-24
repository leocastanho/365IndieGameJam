extends Area2D

func _on_LightOn_body_entered(body):
	if not Global.lightON:
		Global.Player.get_node("CanvasModulate/AnimationPlayer").play("lights_on")
		Global.lightON = true
