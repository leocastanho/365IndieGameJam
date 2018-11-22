extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum STATES {IDLE, PREPARE_ATTACK, ATTACKING}

onready var anim = $AnimationPlayer
onready var timer = $Timer

onready var bullet = preload("res://Scenes/Bullet.tscn")

var state
var mother

func _change_state(new_state):
	
	match new_state:
		IDLE:
			anim.play("Idle")
			timer.wait_time = 1.5
			timer.start()
		PREPARE_ATTACK:
			anim.play("Prepare_Attack")
		ATTACKING:
			anim.play("Attacking")
			
	state = new_state

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	_change_state(IDLE)
	
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if(!mother):
		mother = get_node("../Mother")
		
	pass
	
func attack():
	
	var shoot = bullet.instance()
	shoot.position = $SpawnBullet.global_position
	shoot.rotation = rotation
	shoot.scale = shoot.scale * 2
	$Bullets.add_child(shoot)
	shoot.changeDirection(mother.position - shoot.position)
	
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	
	match state:
		PREPARE_ATTACK:
			_change_state(ATTACKING)
		ATTACKING:
			if(mother):
				attack()
			_change_state(IDLE)
	
	pass # replace with function body


func _on_Timer_timeout():
	
	if(!mother):
		_change_state(IDLE)
	else:
		_change_state(PREPARE_ATTACK)
	
	pass # replace with function body
