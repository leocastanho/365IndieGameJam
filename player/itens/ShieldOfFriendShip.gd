extends Node2D

var shield_on_cd = false
var normal_walk_speed
var normal_run_speed

func _ready():
	normal_walk_speed = owner.get_node("StateMachine/Move").MAX_WALK_SPEED
	normal_run_speed = owner.get_node("StateMachine/Move").MAX_RUN_SPEED

func _input(event):
	if Input.is_action_pressed("shield") and not shield_on_cd:
		print("eita")
		owner.get_node("HitBox/CollisionShape2D").disabled = true
		owner.get_node("StateMachine/Move").MAX_WALK_SPEED = 100
		owner.get_node("StateMachine/Move").MAX_RUN_SPEED = 200
		$ShieldDuration.start()
		shield_on_cd = true

func _on_ShieldDuration_timeout():
	owner.get_node("HitBox/CollisionShape2D").disabled = false
	owner.get_node("StateMachine/Move").MAX_WALK_SPEED = normal_walk_speed
	owner.get_node("StateMachine/Move").MAX_RUN_SPEED = normal_run_speed
	$ShieldCD.start()


func _on_ShieldCD_timeout():
	shield_on_cd = false
