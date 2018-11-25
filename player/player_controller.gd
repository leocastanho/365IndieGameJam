extends KinematicBody2D

signal direction_changed(new_direction)

var look_direction = Vector2(1, 0) setget set_look_direction

var wich_object

func _ready():
	Global.Player = self
	$CanvasModulate/AnimationPlayer.connect("animation_finished", get_node("/root/BigScene/Level/dialogue_system"), "_on_AnimationPlayer_animation_finished")

func take_damage_from(attacker, amount, effect=null):
	if self.is_a_parent_of(attacker):
		return
	#EnemyPos used on knockback
	$StateMachine/Stagger.enemyPos = attacker.global_position
	#Makes MOVE State send signal to StateMachine to change the state do STAGGER
	$StateMachine/Move.emit_signal("finished", "stagger")
	$Health.take_damage(amount, effect)

func set_dead(value):
#	queue_free()
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionPolygon2D.disabled = value
#	visible = false

func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)
	
func unlock_object_anim(object):
	$object.texture = object
	if object == Global.love_stone_texture or object == Global.family_stone_texture or object == Global.spirit_stone_texture or object == Global.friendship_stone_texture:
		$object.scale = Vector2(0.31,0.31)
	else:
		$object.scale = Vector2(1,1)
	$ObjectsAnimator.play("unlock_object")
	wich_object = object

func _on_StonesAnimator_animation_finished(anim_name):
	$Tween.interpolate_property($object, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	match wich_object:
		Global.love_stone_texture:
			Global.item_list.add_icon_item(Global.love_stone_texture, false)
		Global.spirit_stone_texture:
			Global.item_list.add_icon_item(Global.spirit_stone_texture, false)
		Global.key_texture:
			get_node("/root/Level3/PlayerInterface/Interface/Keys").add_icon_item(Global.key_texture, false)

#func _input(event):
#	if Input.is_action_pressed("run"):
#		Engine.time_scale = 0
#	if Input.is_action_pressed("attack"):
#		Engine.time_scale = 1