extends KinematicBody2D

signal direction_changed(new_direction)

var look_direction = Vector2(1, 0) setget set_look_direction

var wich_object

var canDamage = true

func _ready():
	Global.Player = self
	if Global.player_position != null and get_tree().get_current_scene().name == "Level":
		position = Global.player_position
#	$CanvasModulate/AnimationPlayer.connect("animation_finished", get_node("/root/Level/dialogue_system"), "_on_AnimationPlayer_animation_finished")
	if Global.begin_anim_once:
		$CanvasModulate/AnimationPlayer.play("idle")
	elif not Global.begin_anim_once:
		$CanvasModulate/AnimationPlayer.play("BeginAnim")

	#this part verify if the player already unlocked an item or stone
	#Area1
	if Global.sword_of_love_unlock:
		var sword = Global.sword_of_love.instance()
		Global.Player.get_node("WeaponPivot/Offset/Sword").queue_free()
		Global.Player.get_node("WeaponPivot/Offset").add_child(sword)
	if Global.freedom_cape_unlock:
		var cape = Global.freedom_cape.instance()
		Global.Player.add_child(cape)
	#Area2
	#Life potion on health script
	#Area3
	if Global.speed_boots_unlock:
		var speed_boots = Global.speed_boots.instance()
		Global.Player.add_child(speed_boots)
	if Global.time_potion_unlock:
		var time_potion = Global.time_potion.instance()
		Global.Player.add_child(time_potion)
	#Area4
	if Global.shield_of_friendship_unlock:
		var shield = Global.shield_of_friendship.instance()
		Global.Player.get_node("WeaponPivot/Offset").add_child(shield)
	if Global.staff_of_rottenness_unlock:
		var staff = Global.staff_of_rottenness.instance()
		Global.Player.add_child(staff)

func take_damage_from(attacker, amount, effect=null):
	
	if(canDamage):
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
	elif object == Global.key_texture:
		$object.scale = Vector2(1,1)
	else:
		$object.scale = Vector2(0.1,0.1)
	$ObjectsAnimator.play("unlock_object")
	wich_object = object

func _on_StonesAnimator_animation_finished(anim_name):
	$Tween.interpolate_property($object, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	match wich_object:
		Global.love_stone_texture:
			Global.item_list.add_icon_item(Global.love_stone_texture, false)
			Global.love_stone_unlocked = true
			wich_object = null
		Global.family_stone_texture:
			Global.item_list.add_icon_item(Global.family_stone_texture, false)
			Global.family_stone_unlocked = true
			wich_object = null
		Global.spirit_stone_texture:
			Global.item_list.add_icon_item(Global.spirit_stone_texture, false)
			wich_object = null
			Global.spirit_stone_unlocked = true
		Global.friendship_stone_texture:
			Global.item_list.add_icon_item(Global.friendship_stone_texture, false)
			Global.friendship_stone_unlocked = true
			wich_object = null
		Global.key_texture:
			get_node("/root/PlayerInterface/Interface/Keys").add_icon_item(Global.key_texture, false)
			wich_object = null

#func _input(event):
#	if Input.is_action_pressed("run"):
#		Engine.time_scale = 0
#	if Input.is_action_pressed("attack"):
#		Engine.time_scale = 1