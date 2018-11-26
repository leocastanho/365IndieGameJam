extends KinematicBody2D

var direction = Vector2()
export(float) var SPEED = 1000.0
export(int) var damage = 0

var hit_objects = []

onready var destroy_effect = preload("res://Scenes/Poison.tscn")

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
#	if is_outside_view_bounds():
#		queue_free()

	var motion = direction * SPEED #* delta
	move_and_slide(motion)
#	var collision_info = move_and_collide(motion)
#	if collision_info:
#		queue_free()

#func is_outside_view_bounds():
#	return position.x > OS.get_screen_size().x or position.x < 0.0 \
#		or position.y > OS.get_screen_size().y or position.y < 0.0

#func _draw():
#	draw_circle(Vector2(), $CollisionShape2D.shape.radius, Color('#ffffff'))

func _on_DamageDealer_body_entered(body):
	if not body.has_node('Health'):
		var destroy_effect_spawn = destroy_effect.instance()
		body.add_child(destroy_effect_spawn)
		queue_free()
		return
	if body.get_rid().get_id() in hit_objects:
		return
	hit_objects.append(body.get_rid().get_id())
	body.take_damage(self, damage, global_constants.STATUS_POISONED)
	var destroy_effect_spawn = destroy_effect.instance()
	body.add_child(destroy_effect_spawn)
	queue_free()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
