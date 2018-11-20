extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum STATE {IDLE, WALK, 
			FOLLOW, PREPARE_ATTACK, ATTACKING, 
			DIED}

export(int) var walkSpeed = 100
export(int) var attackSpeed = 150

export(int) var life = 100
export(int) var power = 10

var speed

var timeChange
var direction

var player

onready var tween = get_node("Tween")
	

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	life = 100
	direction = Vector2(1, 0)
	speed = walkSpeed
	timeChange = 0
	
	randomize()
	STATE = IDLE
	
	pass

func _change_state(new_state):
	
	match new_state:
		IDLE:
			direction.x = 0
			direction.y = 0
			speed = 0
		WALK:
			var x = rand_range(-1, 1)
			var y = rand_range(-1, 1)
			direction.x = x
			direction.y = y
			speed = walkSpeed
		FOLLOW:
			speed = walkSpeed
		PREPARE_ATTACK:
			direction =  player.position - self.position
			direction = direction.normalized()
			tween.interpolate_property(get_node("exclamation"), "modulate",
	        get_node("exclamation").modulate, Color(1,1,1,1), 1,
	        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			speed = 0
		ATTACKING:
			speed = attackSpeed
		DIED:
			queue_free()
	
	STATE = new_state
	pass

func _physics_process(delta):
	timeChange += delta

	if(player == null):
		
		translate(direction * speed * delta)
		if(timeChange > 1 && STATE != IDLE):
			_change_state(IDLE)
			timeChange = 0
		elif(timeChange > 1 && STATE == IDLE):
			_change_state(WALK)
			timeChange = 0
	else:
		if(STATE == IDLE):
			if(timeChange > 0.5):
				_change_state(FOLLOW)
		elif(timeChange > 3 && STATE == FOLLOW):		
			_change_state(PREPARE_ATTACK)
		elif(STATE == ATTACKING):
			translate(direction * speed * delta)
			if(timeChange > 1):
				_change_state(IDLE)
				timeChange == 0
				$exclamation.modulate.a = 0
		elif(STATE == FOLLOW):
			direction =  player.position - self.position
			direction = direction.normalized()
			translate(direction * speed * delta)
			
	pass


func _on_Detection_body_entered(body):

	if(body != self && body.is_in_group("Player")):
		if(!player):
			player = body
			_change_state(FOLLOW)

	
	pass # replace with function body

func _on_Tween_tween_completed(object, key):
	_change_state(ATTACKING)
	timeChange = 0
	
	pass # replace with function body


func _on_MonsterMelee_body_entered(body):
	
	pass # replace with function body
