extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var laser_color = Color(1.0, .329, .298)
var target 
var hit_pos
var can_shoot
var life

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	life = 100
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	update()
	target = get_node("../Help")
	if(target):
		aim()
		
	pass

func aim():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, target.position, [self], collision_mask)
	if result:
		hit_pos = result.position
		if result.collider.name == "Help":
			rotation = (target.position - position).angle()
			if can_shoot:
				shoot(target.positon)
	
	pass

func shoot():
	
	pass

func _draw():
	
	if(hit_pos):
		draw_circle((hit_pos - position).rotated(-rotation), 5, laser_color)
		draw_line(Vector2(), (hit_pos - position).rotated(-rotation), laser_color)
		
	pass

func _on_MonsterRanged_body_shape_entered(body_id, body, body_shape, local_shape):

		
	
	pass # replace with function body
