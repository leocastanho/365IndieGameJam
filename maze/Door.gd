extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body == Global.Player and Global.key_count >= 3 and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("open")

func open_door():
	$AnimationPlayer.play("open")