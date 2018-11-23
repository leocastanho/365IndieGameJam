extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var anim = $AnimationPlayer

var direction = Vector2()
var speed = 100

var father
var enemy

func _ready():
	
	anim.play("Idle")
	$HealthBar.value = $HealthBar.max_value
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if(!father):
		father = get_node("../Father")
	else:
		if(!enemy):
			direction = father.position - position
		else:
			update()
			direction = enemy.position - position

		direction = direction.normalized()	
		var collide = move_and_collide(direction * speed * delta)
		if(collide):
			move_and_slide(direction * speed)
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	
	anim.play("Idle")
	
	pass # replace with function body
	
func take_damage(damage_dealer,damage,effect):
	$Health.take_damage(damage,effect)

func _on_Detection_body_entered(body):
	
	if(body.is_in_group("Father") && !enemy):
		enemy = body
	
	pass # replace with function body
