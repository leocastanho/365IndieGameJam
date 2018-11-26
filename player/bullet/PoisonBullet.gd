extends KinematicBody2D

var direction = Vector2()
export(float) var SPEED = 1000.0
export(int) var damage = 0

var hit_objects = []

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	if is_outside_view_bounds():
		queue_free()

	var motion = direction * SPEED #* delta
	move_and_slide(motion)
#	var collision_info = move_and_collide(motion)
#	if collision_info:
#		queue_free()

func is_outside_view_bounds():
	return position.x > OS.get_screen_size().x or position.x < 0.0 \
		or position.y > OS.get_screen_size().y or position.y < 0.0

#func _draw():
#	draw_circle(Vector2(), $CollisionShape2D.shape.radius, Color('#ffffff'))

func _on_DamageDealer_body_entered(body):
	if not body.has_node('Health'):
		return
	if body.get_rid().get_id() in hit_objects:
		return
	hit_objects.append(body.get_rid().get_id())
	body.take_damage(self, damage, global_constants.STATUS_POISONED)
	queue_free()
