extends "on_ground.gd"

export(float) var MAX_WALK_SPEED = 450
export(float) var MAX_RUN_SPEED = 700

var velocityMultiplier = 1
export var dashVelocityMultiplier = 6
var dashCD = false

#usando particle blood por enquanto, depois tem que fazeruma pro dash
onready var freedom_particle = preload ("res://Scenes/Blood.tscn")

func enter():
	speed = 0.0
	velocity = Vector2()

	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	owner.get_node("AnimationPlayer").play("walk")

func handle_input(event):
	return .handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	update_look_direction(input_direction)
	if Input.is_action_just_pressed("dash") and not dashCD and Global.Player.has_node("FreedomCape"):
		dash()

#	speed = MAX_RUN_SPEED if Input.is_action_pressed("run") else MAX_WALK_SPEED
	speed = MAX_RUN_SPEED if Global.Player.has_node("SpeedBoots") else MAX_WALK_SPEED
	var collision_info = move(speed, input_direction)
	if not collision_info:
		return
	if speed == MAX_RUN_SPEED and collision_info.collider.is_in_group("environment"):
		return null

func move(speed, direction):
	velocity = direction.normalized() * speed
	owner.move_and_slide(velocity * velocityMultiplier, Vector2(), 5, 2)
	if owner.get_slide_count() == 0:
		return
	return owner.get_slide_collision(0)

func dash():
	#Dash option 1 - move to looking location
	velocityMultiplier = dashVelocityMultiplier
	get_node("../../Dash").start()
	var freedom = freedom_particle.instance()
	Global.Player.add_child(freedom)

	#Dash option 2 - move to mouse location
#	var dash_vector = (get_global_mouse_position() - position).clamped(dashDistance)
#	var dash_target = position + dash_vector
#	var tween = $Tween
#	tween.interpolate_property(self, "position", position, dash_target, dashDuration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
#	tween.start()

#	Cooldown
	dashCD = true
	get_node("../../DashCD").start()

func _on_Dash_timeout():
	velocityMultiplier = 1

func _on_DashCD_timeout():
	dashCD = false
