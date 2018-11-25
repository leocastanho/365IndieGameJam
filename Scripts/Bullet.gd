extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var damage
var speed
var direction

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	damage = 10
	direction = Vector2()
	speed = 300
	
	pass
	
func changeDirection(newDirection):
	direction = newDirection.normalized()

func _process(delta):
	position += direction * speed * delta
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass


func _on_Bullet_body_entered(body):
	queue_free()

	pass # replace with function body
