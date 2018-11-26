
extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum STATES {IDLE, WALK, 
			FOLLOW, PREPARE_ATTACK, ATTACKING, DIED}

export(int) var walkSpeed = 100
export(int) var attackSpeed = 200

onready var timer = $Timer
onready var anim_player = $AnimationPlayer
onready var lifeBar = $HealthBar

onready var smokeDie = preload("res://Scenes/Monsters/Smoke.tscn")

var state

var speed
var direction
var player
	
func take_damage(damage_dealer,damage,effect):
	if(state != DIED):
		$Health.take_damage(damage,effect)

	
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	direction = Vector2()
	speed = walkSpeed
	lifeBar.value = lifeBar.max_value
	
	self.anim_player.connect('animation_finished', self, '_on_AnimationPlayer_animation_finished')
	self.timer.connect('timeout', self, '_on_Timer_timeout')
	_change_state(IDLE)

	
	pass

func _change_state(new_state):
	match new_state:
		IDLE:
			direction.x = 0
			direction.y = 0
			speed = 0
			anim_player.play("Idle")
			timer.wait_time = 0.5
			timer.start()
		WALK:
			randomize()
			var x = rand_range(-1, 1)
			var y = rand_range(-1, 1)
			direction.x = x
			direction.y = y
			speed = walkSpeed
			timer.wait_time = 1.5
			timer.start()
		FOLLOW:
			speed = walkSpeed
			timer.wait_time = 1.5
			timer.start()
		PREPARE_ATTACK:
				direction = player.position - self.position
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
	state = new_state	
	
	pass

func move(delta):
	var collide = move_and_collide(direction * speed * delta)
	if(collide):
		move_and_slide(direction * speed)	
	
func _physics_process(delta):
	
	var current_state = state
	
	if(!player):
		#Andando e Parando
		match current_state:
			WALK:
				move(delta)
	else:
		if(current_state == FOLLOW):		
				direction =  player.position - self.position
				direction = direction.normalized()
				move(delta)
		elif(current_state == ATTACKING):
			move(delta)
	pass


func _on_Detection_body_entered(body):

	if(body != self && body.is_in_group("Player")):
		if(!player):
			player = body
			_change_state(FOLLOW)
			#print("Encontrou")

	
	pass # replace with function body

func died():
	
	if(state != DIED):
		if($DamageSource):	
			$DamageSource.queue_free()
			
		state = DIED
		var inst = smokeDie.instance()
		add_child(inst)
		inst.play("SmokeDie")
		anim_player.play("Died")

func _on_MonsterMelee_body_entered(body):
	
	pass # replace with function body


func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "Prepare_Attack"):
		_change_state(ATTACKING)
	elif(anim_name == "Idle"):
		anim_player.play(anim_name)
	elif(anim_name == "Died"):
		_change_state(DIED)
	
	pass # replace with function body


func _on_Timer_timeout():	

	if(state != DIED):
		if(!player):
			if(state == IDLE):
				_change_state(WALK)
			elif(state != IDLE):
				_change_state(IDLE)
		else:		
			if(state == IDLE):
				_change_state(FOLLOW)
				
			elif(state == FOLLOW):
				_change_state(PREPARE_ATTACK)
			
			elif(state == ATTACKING):
				_change_state(IDLE)
	
	pass # replace with function body
