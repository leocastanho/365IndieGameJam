extends Node2D

var time_potion_cd = false
var normal_walk_speed
var normal_run_speed
var time_scale = 0.3

func _ready():
	normal_walk_speed = owner.get_node("StateMachine/Move").MAX_WALK_SPEED
	normal_run_speed = owner.get_node("StateMachine/Move").MAX_RUN_SPEED

func _input(event):
	if Input.is_action_pressed("slow_time") and not time_potion_cd:
		Engine.time_scale = 0.3
		print("aasdasd")
		owner.get_node("StateMachine/Move").MAX_WALK_SPEED /= time_scale
		owner.get_node("StateMachine/Move").MAX_RUN_SPEED /= time_scale
		print(owner.get_node("StateMachine/Move").MAX_WALK_SPEED)
		print(owner.get_node("StateMachine/Move").MAX_RUN_SPEED)
		$Timer.start()
		time_potion_cd = true

func _on_Timer_timeout():
	Engine.time_scale = 1
	owner.get_node("StateMachine/Move").MAX_WALK_SPEED = normal_walk_speed
	owner.get_node("StateMachine/Move").MAX_RUN_SPEED = normal_run_speed
	$TimerCD.start()

func _on_TimerCD_timeout():
	time_potion_cd = false