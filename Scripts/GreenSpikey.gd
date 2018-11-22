extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var anim = $AnimationPlayer
onready var timer = $Timer

var direction = Vector2()
var speed = 100

var mother
var enemy

func _ready():

	anim.play("Idle")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	move_in_direction()
	
	pass

func move_in_direction():
	
	if(mother):
		if(!enemy):
			direction = mother.position - position
		else:
			direction = enemy.position - position
		
	timer.wait_time = 0.5
	timer.start()

func _physics_process(delta):
	
	if(!mother):
		mother = get_node("../Mother")
	else:
		direction = direction.normalized()
		var collide = move_and_collide(direction * speed * delta)
		if(collide):
			move_and_slide(direction * speed)
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	
	anim.play("Idle")
	
	pass # replace with function body


func _on_Detection_body_entered(body):

	if(body.is_in_group("Mother") && !enemy):
		enemy = body

	pass # replace with function body


func _on_Timer_timeout():
	
	move_in_direction()
	
	pass # replace with function body
