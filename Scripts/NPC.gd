extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(int) var life

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$LifeBar.max_value = life
	$LifeBar.value = life
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if(isDied()):
		queue_free()
		
	pass
	
func isDied():
	if(life <= 0):
		return true
	
	return false

func take_Damage(value):
	
	life -= value
	$LifeBar.value = life
	
	pass

func _on_NPC_body_entered(body):

	if(body.is_in_group("Bullet")):
		$AnimationPlayer.play("Take_Damage")
		take_Damage(body.damage)
		body.queue_free()
	
	pass # replace with function body
