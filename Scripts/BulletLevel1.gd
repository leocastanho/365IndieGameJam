extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var damage = 10
export var min_speed_multiplier = 10
export var max_speed_multiplier = 15
var speed
var direction

func _ready():
	speed = (randi() % max_speed_multiplier + min_speed_multiplier) * 100
	# Called when the node is added to the scene for the first time.
	# Initialization here
	direction = Vector2()
	
	pass
	
func changeDirection(newDirection):
	direction = newDirection.normalized()

func _process(delta):
	position += direction * speed * delta
	if not $VisibilityNotifier2D.is_on_screen():
		queue_free()
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass


func _on_Bullet_body_entered(body):


	pass # replace with function body
