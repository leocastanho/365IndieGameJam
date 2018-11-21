extends KinematicBody2D

signal direction_changed(new_direction)

var look_direction = Vector2(1, 0) setget set_look_direction

func _ready():
	Global.Player = self

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
