extends Node2D

var time_potion_cd = false
var normal_walk_speed
var normal_run_speed
var time_scale = 0.3
var state_move

func _ready():
	state_move = Global.state_move
	normal_walk_speed = state_move.MAX_WALK_SPEED
	normal_run_speed = state_move.MAX_RUN_SPEED

func _input(event):
	if Input.is_action_pressed("slow_time") and not time_potion_cd:
		Engine.time_scale = 0.3
		state_move.MAX_WALK_SPEED /= time_scale
		state_move.MAX_RUN_SPEED /= time_scale
		$Timer.start()
		time_potion_cd = true

func _on_Timer_timeout():
	Engine.time_scale = 1
	state_move.MAX_WALK_SPEED = normal_walk_speed
	state_move.MAX_RUN_SPEED = normal_run_speed
	$TimerCD.start()

func _on_TimerCD_timeout():
	time_potion_cd = false