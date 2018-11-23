extends Node2D

var time_potion_cd = false

func _input(event):
	if Input.is_action_pressed("slow_time") and not time_potion_cd:
		Engine.time_scale = 0.3
		$Timer.start()
		time_potion_cd = true

func _on_Timer_timeout():
	Engine.time_scale = 1
	$TimerCD.start()

func _on_TimerCD_timeout():
	time_potion_cd = false