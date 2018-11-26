extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum STATES {IDLE, FOLLOW, DIE}
onready var anim = $AnimationPlayer

onready var smokeDie = preload("res://Scenes/Monsters/Smoke.tscn")

var state
var direction = Vector2()
var speed = 100

var father
var enemy

var canDamage = true

func _ready():
	
	anim.play("Idle")
	$HealthBar.value = $HealthBar.max_value
	
	state = IDLE
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if(!father):
		father = get_node("../../Father")
	else:
		if(!enemy):
			direction = father.position - position
		else:
			if(!enemy.isDied()):
				direction = enemy.position - position
			else:
				enemy = null

		direction = direction.normalized()	
		var collide = move_and_collide(direction * speed * delta)
		if(collide):
			move_and_slide(direction * speed)
	pass


func died():
	if(state != DIE):
		state = DIE
		anim.play("Die")
		var inst = smokeDie.instance()
		add_child(inst)
		inst.play("SmokeDie")
	pass
	
func activate_dont_damage():
	canDamage = false
	
func activate_damage():
	canDamage = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "Idle"):
		anim.play("Idle")
	elif (anim_name == "Die"):
		queue_free()
	
	pass # replace with function body
	
func isDied():
	if(state == DIE):
		return true
	
	return false
	
func take_damage(damage_dealer, damage, effect):
	if(state != DIE && canDamage):
		$Health.take_damage(damage,effect)

func _on_Detection_body_entered(body):
	
	if(body.is_in_group("Father") && !enemy):
		enemy = body
	
	pass # replace with function body
		
