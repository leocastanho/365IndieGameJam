extends Node2D

var shield_on_cd = false
var normal_walk_speed
var normal_run_speed
var state_move

func _ready():
	state_move = Global.state_move
	normal_walk_speed = state_move.MAX_WALK_SPEED
	normal_run_speed = state_move.MAX_RUN_SPEED

func _input(event):
	if Input.is_action_pressed("shield") and not shield_on_cd:
		print("eita")
		#Global.Player.get_node("HitBox/CollisionShape2D").disabled = true
		Global.Player.canDamage = false
		state_move.MAX_WALK_SPEED = 100
		state_move.MAX_RUN_SPEED = 200
		$ShieldDuration.start()
		shield_on_cd = true
		$Sprite.visible = true

func _on_ShieldDuration_timeout():
	Global.Player.get_node("HitBox/CollisionShape2D").disabled = false
	state_move.MAX_WALK_SPEED = normal_walk_speed
	state_move.MAX_RUN_SPEED = normal_run_speed
	$ShieldCD.start()
	$Sprite.visible = false

func _on_ShieldCD_timeout():
	Global.Player.canDamage = true
	shield_on_cd = false
