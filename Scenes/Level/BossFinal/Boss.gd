extends KinematicBody2D

enum STATES {IDLE, ATTACK, HIDE, SHOW, DIE}
enum PHASES {EASY, NORMAL, HARD, MASTER}

var state
var phase

onready var anim = $AnimatedSprite
onready var teleportAnim = $AnimationPlayer

var timesAttack
var timesTeleport

var count

var waitIdle

var isAttack = true

func take_damage(damage_dealer,damage,effect):
	if(state != DIE):
		$Health.take_damage(damage,effect)

func _ready():
	
	waitIdle = 5
	timesAttack = 1
	timesTeleport = 1
	
	_change_state(IDLE)
	_next_phase(EASY)

	
	pass

func _change_state(new_state):
	
	match new_state:
		IDLE:
			anim.play("Idle")
			$Timer.wait_time = waitIdle
			$Timer.start()
		ATTACK:
			match count:
				EASY:
					get_node("../../").spawnEasy()
				NORMAL:
					get_node("../../").spawnNormal()
				HARD:
					get_node("../../").spawnHard()
				MASTER:
					get_node("../../").spawnMaster()
					
			anim.play("Attack")
		HIDE:
			teleportAnim.play("Hide")
		SHOW:
			randomize()
			var newPosition = randi()%5
			get_node("../../").whereTeleport(newPosition)
			teleportAnim.play("Show")
		DIE:
			anim.play("Die")
		
	state = new_state
	
	pass

func _next_phase(new_phase):
	
	match new_phase:
		EASY:
			timesAttack = 1
			timesTeleport = 1
		NORMAL:
			timesAttack = 2
			timesTeleport = 2
		HARD:
			timesAttack = 3
			timesTeleport = 3
		MASTER:
			timesAttack = 4
			timesTeleport = 4
			
	phase = new_phase
	
	pass

func _process(delta):
	
	if(state != DIE):
		if($Health.health/$Health.max_health <= 0.8 && phase > NORMAL):
			_next_phase(NORMAL)
		elif ($Health.health/$Health.max_health <= 0.5 && phase > HARD):
			_next_phase(HARD)
		elif ($Health.health/$Health.max_health <= 0.3 && phase > MASTER):
			_next_phase(MASTER)
		
	pass


func _on_AnimatedSprite_animation_finished():
	
	match state:
		ATTACK:
			count += 1
			if(count < timesAttack):
				print(timesAttack)
				print(count)
				_change_state(ATTACK)
			else:
				_change_state(IDLE)
		DIE:
			anim.stop()
			return
			
	
	
	pass # replace with function body
func died():
	state = DIE
	_change_state(DIE)
	$Health.queue_free()
	$DamageSource.queue_free()
	$Timer.queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	match state:
		SHOW:
			count += 1
			if(count < timesTeleport):
				_change_state(HIDE)
			else:
				_change_state(IDLE)
		HIDE:
			_change_state(SHOW)
	
	pass # replace with function body


func _on_Timer_timeout():
	count = 0
	
	if(isAttack):
		_change_state(ATTACK)
		isAttack = false
	else:
		_change_state(HIDE)
		isAttack = true
	
	pass # replace with function body
