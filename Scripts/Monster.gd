extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var direction
var speed
var life
var attack

var timeChange

var player

onready var tween = get_node("Tween")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	life = 100
	direction = Vector2(1, 0)
	speed = 5
	timeChange = 0
	
	pass

func _process(delta):
	
	if(player == null):
		timeChange += delta
		
		translate(direction * speed)
		if(timeChange > 1):
			timeChange = 0
			direction.x = direction.x * -1
	else:
		direction =  player.position - self.position
		direction.normalized()
		#print(direction)
		translate(direction * speed * delta)
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass


func _on_Detection_body_entered(body):

	if(body != self && body.is_in_group("Monsters")):
		print("Atack Now")
		tween.interpolate_property(get_node("exclamation"), "modulate",
        get_node("exclamation").modulate, Color(1,1,1,1), 1,
        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		player = body
		speed = 0
	
	pass # replace with function body


func _on_Monster_body_entered(body):
	
	print("Stop Walk")
	speed = 0
	
	pass # replace with function body


func _on_Tween_tween_completed(object, key):
	speed = 3
	
	pass # replace with function body
