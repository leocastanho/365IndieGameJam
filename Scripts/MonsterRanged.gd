extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var laser_color = Color(1.0, 0, 0)
onready var bullet = preload("res://Scenes/Bullet.tscn")

var target 

var hit_pos
var can_shoot = false
var direction

export(int) var damage = 10
export(int) var life = 100
export(int) var speed = 0
export(float) var timeReload = 3

var timePassed = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$LifeBar.max_value = life
	$LifeBar.value = life
	
	pass

func _physics_process(delta):
	target = get_node("../Help")
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	timePassed += delta
	if(timePassed > timeReload):
		can_shoot = true
		timePassed = 0
	
	update()
	if(target):
		aim()
	else:
		hit_pos = null
		
	pass

func aim():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, target.position, [self], collision_mask)
	if result:
		hit_pos = result.position
		if result.collider.name == "Help":
			if(can_shoot):
				shoot()
				can_shoot = false
	
	pass

func shoot():
	var shoot = bullet.instance()
	shoot.position = position 
	shoot.rotation = rotation
	$Bullets.add_child(shoot)
	shoot.changeDirection(target.position - position)
	
	pass

func _draw():
	
	if(hit_pos):
		draw_circle((hit_pos - position).rotated(-rotation), 5, laser_color)
		draw_line(Vector2(), (hit_pos - position).rotated(-rotation), laser_color, 2)
		
	pass

func _on_MonsterRanged_body_shape_entered(body_id, body, body_shape, local_shape):

		
	
	pass # replace with function body
