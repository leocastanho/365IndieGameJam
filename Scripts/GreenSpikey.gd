extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum STATES {IDLE, FOLLOW, DIE}
var state

onready var anim = $AnimationPlayer
onready var timer = $Timer

var direction = Vector2()
var speed = 100

var mother
var enemy

var canDamage = true

func _ready():

	$HealthBar.value = $HealthBar.max_value
	anim.play("Idle")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	move_in_direction()
	state = IDLE
	
	pass

func activate_dont_damage():
	canDamage = false

func move_in_direction():
	
	if(mother):
		if(!enemy):
			direction = mother.position - position
		else:
			if(!enemy.isDied()):
				direction = enemy.position - position
			else:
				enemy = null
		
	timer.wait_time = 0.5
	timer.start()

func _physics_process(delta):
	
	if(!mother):
		mother = get_node("../../Mother")
	else:
		direction = direction.normalized()
		var collide = move_and_collide(direction * speed * delta)
		if(collide):
			move_and_slide(direction * speed)
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func isDied():
	if(state == DIE):
		return true
	
	return false

func died():
	state = DIE
	$Collision.hide()
	anim.play("Die")
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	
	if(anim_name == "Idle"):
		anim.play("Idle")
	elif (anim_name == "Die"):
		queue_free()
	
	pass # replace with function body


func take_damage(damage_dealer, damage, effect):
	if(state != DIE && canDamage):
		$Health.take_damage(damage,effect)

func _on_Detection_body_entered(body):

	if(body.is_in_group("Mother") && !enemy):
		enemy = body

	pass # replace with function body


func _on_Timer_timeout():
	
	move_in_direction()
	
	pass # replace with function body
