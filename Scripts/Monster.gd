extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum STATE {IDLE, WALK, 
			FOLLOW, PREPARE_ATTACK, ATTACKING, 
			DIED}

export(int) var walkSpeed = 100
export(int) var attackSpeed = 200

export(int) var life = 100
export(int) var damage = 10

onready var timer = $Timer
onready var lifeBar = $LifeBar

var speed
var direction

var player

onready var tween = get_node("Tween")
	

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	life = 100
	direction = Vector2(1, 0)
	speed = walkSpeed
	lifeBar.max_value = life
	lifeBar.value = life
	
	_change_state(IDLE)
	
	pass

func _change_state(new_state):
	
	STATE = new_state
	
	match new_state:
		IDLE:
			direction.x = 0
			direction.y = 0
			speed = 0
			timer.wait_time = 1
			timer.start()
		WALK:
			randomize()
			var x = rand_range(-1, 1)
			var y = rand_range(-1, 1)
			direction.x = x
			direction.y = y
			speed = walkSpeed
			timer.wait_time = 3
			timer.start()
		FOLLOW:
			speed = walkSpeed
			timer.wait_time = 2
			timer.start()
		PREPARE_ATTACK:
			if(player):
				direction =  player.position - self.position
				direction = direction.normalized()
				$AnimationPlayer.play("Prepare_Attack")
				speed = 0
		ATTACKING:
			speed = attackSpeed
			$Dust.rotation = direction.angle()
			$AnimationPlayer.play("Attacking")
			timer.wait_time = 1.5
			timer.start()
		DIED:
			queue_free()
	pass

func move(delta):
	var collide = move_and_collide(direction * speed * delta)
	if(collide):
		move_and_slide(direction * speed)	
	
func _physics_process(delta):
	if(!player):
		#Andando e Parando
		if(STATE == WALK):
			move(delta)
	else:
		if(STATE == FOLLOW):		
				direction =  player.position - self.position
				direction = direction.normalized()
				move(delta)
		elif(STATE == ATTACKING):
			move(delta)
	pass


func _on_Detection_body_entered(body):

	if(body != self && body.is_in_group("Player")):
		if(!player):
			player = body
			_change_state(FOLLOW)
			#print("Encontrou")

	
	pass # replace with function body

func take_Damage(damage):
	life -= damage
	lifeBar.value = life


func _on_MonsterMelee_body_entered(body):
	
	if(body.name == "Sword"):
		take_Damage(10)
		
	
	
	pass # replace with function body


func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "Prepare_Attack"):
		_change_state(ATTACKING)
	
	pass # replace with function body


func _on_Timer_timeout():
	
	if(STATE == IDLE):
		if(!player):
			_change_state(WALK)
		else:
			_change_state(FOLLOW)
			
	elif(STATE == WALK):
		_change_state(IDLE)
		
	elif(STATE == FOLLOW):
		_change_state(PREPARE_ATTACK)
	
	elif(STATE == ATTACKING):
		_change_state(IDLE)
	
	pass # replace with function body
