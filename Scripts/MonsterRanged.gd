extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var laser_color = Color(1.0, 0, 0)
onready var bullet = preload("res://Scenes/Bullet.tscn")

enum states {IDLE ,DIED}

var target 

var hit_pos
var can_shoot = false
var last

var direction

var state

onready var smokeDie = preload("res://Scenes/Monsters/Smoke.tscn")
onready var anim = get_node("AnimationPlayer")

export(int) var speed = 0
export(float) var timeReloadMax = 10
export(float) var timeReloadMin = 5
var timeReload

onready var lifeBar = $HealthBar
var timePassed = 0

var canDamage = false

func take_damage(damage_dealer,damage,effect):
	if(canDamage):
		$Health.take_damage(damage,effect)

func _ready():
	lifeBar.value = lifeBar.max_value
	state = IDLE
	timeReload = randf()* timeReloadMax + timeReloadMin
	pass

func activate_damage():
	canDamage = true

func activate_dont_damage():
	canDamage = false

func _physics_process(delta):
	target = get_node("../../NPC")
	
	if(!target):
		target = get_node("../../PlayerV2")

	timePassed += delta
	if(timePassed > timeReload):
		can_shoot = true
		timePassed = 0
		timeReload = randf() * timeReloadMax + timeReloadMin
	
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
		if result.collider.name == "NPC" || result.collider.name == "HitBox":
			if(can_shoot):
				shoot()
				can_shoot = false
	
	pass

func died():
	state = DIED
	$Health.queue_free()
	$DamageSource.queue_free()
	var inst = smokeDie.instance()
	add_child(inst)
	inst.play("SmokeDie")
	anim.play("Died")

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


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if(anim_name == "Died"):
		queue_free()
	
	pass # replace with function body
