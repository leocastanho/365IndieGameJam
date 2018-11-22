extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var laser_color = Color(1.0, 0, 0)
onready var bullet = preload("res://Scenes/BulletLevel1.tscn")

var target 

var hit_pos
var can_shoot = false
var direction

export(int) var damage = 10
export(int) var life = 100
export(int) var speed = 0
export(float) var timeReload = 3

var timePassed = 0

onready var blood = preload("res://Scenes/Blood.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$HealthBar.max_value = life
	$HealthBar.value = life
	randomize()
	set_physics_process(false)
	pass

func _physics_process(delta):
	
	target = get_node("../../PlayerV2")
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	timePassed += delta

	if(timePassed > timeReload):
		can_shoot = true
#		timePassed = 0
		var rand = randi() % 4
		print(rand)
		if rand == 0:
			timePassed = 0
		else:
			timePassed = timeReload
	
	update()
	if(target):
		aim()
	else:
		hit_pos = null
		
	pass

func aim():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, target.position, [self], collision_mask)
	if result:
		hit_pos = result.position
		if result.collider.name == "HitBox":
			rotation = (target.position - global_position).angle()
			if(can_shoot):
				shoot()
				can_shoot = false
	
	pass

func shoot():
	var shoot = bullet.instance()
	shoot.position = global_position 
	shoot.rotation = rotation
	$Bullets.add_child(shoot)
	shoot.changeDirection(target.position - global_position)
	
	pass

func _draw():
	
	if(hit_pos):
		draw_circle((hit_pos - global_position).rotated(-rotation), 5, laser_color)
		draw_line(Vector2(), (hit_pos - global_position).rotated(-rotation), laser_color, 2)
		
	pass

func _on_MonsterRanged_body_shape_entered(body_id, body, body_shape, local_shape):
	pass # replace with function body

func take_damage(damage_dealer,damage,effect):
	$Health.take_damage(damage,effect)
	$AnimationPlayerHurt.play("hurt")
	var blood_particle = blood.instance()
	add_child(blood_particle)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		Global.Player.unlock_stone_anim(Global.love_stone_texture)
		get_node("/root/Level1/dialogue_system").area1_after_semiboss_interation("optionA")

func _on_RunTimer_timeout():
	set_physics_process(false)
	$AnimationPlayer.stop()
	get_node("/root/Level1/dialogue_system").area1_after_semiboss_interation("optionB")