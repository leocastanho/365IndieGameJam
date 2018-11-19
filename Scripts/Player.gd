extends "res://Scripts/Character.gd"

#const SPEED = 10
#const MAX_SPEED = 200
#const FRICTION = 0.1
#
#var motion = Vector2()
#var playerMoving

var dashCD = false
export var dashVelocityMultiplier = 6 #option 1
#export var dashDistance = 130  #option 2 and 3
#export var dashDuration = 0.2 #option 3

#func _ready():
#	Global.Player = self

func _physics_process(delta):
#	Movement option 1
#	move_and_slide(motion * velocityMultiplier)
	update_motion(delta)

func _input(event):
	if Input.is_action_just_pressed("dash") and not dashCD:
		dash()
#		$PlayerSFX.stream = Global.playerDashing
#		_change_state(STAGGER)
		$ShakingCamera.set_duration(0.1)
		$ShakingCamera.set_shake(true)
		Engine.set_time_scale(1)
	if Input.is_action_just_pressed("slow_time") and not dashCD:
		Engine.set_time_scale(0.4)

	if event.is_action_pressed("attack"):
		heal(1)
#		$PlayerSFX.stream = Global.playerAttacking
		if current_state in [ATTACK, STAGGER, DIE, DEAD]:
			return
		_change_state(ATTACK)
		
#	Dash option 2
#	if Input.is_action_just_pressed("Dash") and not dashCD:
#		if motion.y > 0:
#			dash(Vector2(0,dashDistance))
#		elif motion.y < 0:
#			dash(Vector2(0,-dashDistance))
#		elif motion.x > 0:
#			dash(Vector2(dashDistance,0))
#		elif motion.x < 0:
#			dash(Vector2(-dashDistance,0))

func dash(): #toWhere = Vector2()):
#	Dash option 1
	velocityMultiplier = dashVelocityMultiplier
	$Dash.start()

#	Dash option 2
#	position += toWhere

#	Dash option 3
#	var dash_vector = (get_global_mouse_position() - position).clamped(dashDistance)
#	var dash_target = position + dash_vector
#	var tween = $Tween
#	tween.interpolate_property(self, "position", position, dash_target, dashDuration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
#	tween.start()

#	Cooldown
	dashCD = true
	$DashCD.start()

func update_motion(delta):
	#Movement option1
	input_direction = Vector2()

	#Movement option1A 4 direction movement
#	if Input.is_action_pressed("ui_left"):
#		input_direction.x = -1
#	elif Input.is_action_pressed("ui_right"):
#		input_direction.x = 1
#	elif Input.is_action_pressed("ui_up"):
#		input_direction.y = -1
#	elif Input.is_action_pressed("ui_down"):
#		input_direction.y = 1
	#Movement option1B 8 direction movement
	input_direction.x += int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input_direction.y += int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	#Movement option2 -> maybe put this on character.gd
#	var velocity = Vector2()
#	velocity.x += int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
#	velocity.y += int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
#	velocity = velocity.normalized() * SPEED
	
#	if velocity.x != 0 || velocity.y != 0:
#		playerMoving = true
#	else:
#		playerMoving = false
#
#	if not velocity == Vector2():
#		motion += velocity
#		motion = motion.clamped(MAX_SPEED)
#	else:
#		motion.x = lerp(motion.x, 0, FRICTION)
#		motion.y = lerp(motion.y, 0, FRICTION)

func _on_Dash_timeout():
	velocityMultiplier = 1

func _on_DashCD_timeout():
	dashCD = false

func _on_Tween_tween_completed(object, key):
	_change_state(IDLE)
