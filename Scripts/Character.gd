extends KinematicBody2D

export(String) var weapon_scene_path = "res://Scenes/Weapons/Sword.tscn"

var weapon = null
var weapon_path = ""

onready var animation_player = $AnimationPlayer

enum STATES {IDLE, WALK, ATTACK, STAGGER, DIE, DEAD}
var current_state = null
var previous_state = null

var speed = 10
var max_speed = 200
const FRICTION = 0.1
var look_direction = Vector2(1, 0)
var move_direction = Vector2()
var input_direction = Vector2()
var motion = Vector2()
var playerMoving = false
var velocityMultiplier = 1

export var knockbackDuration = 0.2
export var knockbackDistance = 50
var enemyPos = Vector2()

export var max_health = 5
var health

var facingRight = true
var facingDown = false


func _ready():
	health = max_health
	
	# Weapon setup
	var weapon_instance = load(weapon_scene_path).instance()
	var weapon_anchor = $WeaponSpawnPoint/WeaponAnchorPoint
	weapon_anchor.add_child(weapon_instance)

	weapon = weapon_anchor.get_child(0)

	weapon_path = weapon.get_path()
	weapon.connect("attack_finished", self, "_on_Weapon_attack_finished")

	_change_state(IDLE)


func _physics_process(delta):
#	print(move_direction)
	# Movement
	if current_state == IDLE:
		if input_direction:
			_change_state(WALK)

	#at the moment player is moving only in this state, when he attacks he stops moving
	if current_state == WALK:
		move_direction = input_direction

		#where to look, when i get the sprites i will fix this so that the character look at the right direction
		print(look_direction)
		if move_direction.x:
			look_direction.x = move_direction.x
			if facingRight and look_direction.x < 0:
				rotation_degrees = 180
#				$WeaponSpawnPoint.position.x *= look_direction.x
#				$WeaponSpawnPoint.scale.x = look_direction.x
				facingRight = false
			elif not facingRight and look_direction.x > 0:
#				$WeaponSpawnPoint.position.x *= -look_direction.x
				rotation_degrees = 0
				facingRight = true
		if move_direction.y:
			if facingDown and look_direction.y < 0:
				rotation_degrees = 90
				facingDown = false
			elif not facingDown and look_direction.y > 0:
				rotation_degrees = -90
				facingDown = true
#				look_direction.y = move_direction.y
#				$WeaponSpawnPoint.scale.y = look_direction.y

		#this makes the play goes to idle state when he stops moving(0 motion, not when the player stop pressing directionals)
		if motion == Vector2(0,0):
			_change_state(IDLE)
		
		var velocity = Vector2()
		velocity = input_direction.normalized() * speed
	
		if velocity.x != 0 || velocity.y != 0:
			playerMoving = true
		else:
			playerMoving = false
	
		if not velocity == Vector2():
			motion += velocity
			motion = motion.clamped(max_speed)
		else:
			motion.x = lerp(motion.x, 0, FRICTION)
			motion.y = lerp(motion.y, 0, FRICTION)

		move_and_slide(motion * velocityMultiplier)
		
		#option 1 move_and_colide
#		var motion = move_direction * speed * delta * velocityMultiplier
#		move_and_collide(motion)
		#option 2 move_and_slide
#		var motion = move_direction * speed * velocityMultiplier
#		move_and_slide(motion)


func _change_state(new_state):
	previous_state = current_state
	current_state = new_state

	# initialize/enter the state
	match new_state:
		IDLE:
			animation_player.play("idle")
		ATTACK:
			# see Weapon.gd for damage management
			weapon.attack()
		STAGGER:
			if self == Global.Player:
	#			animation_player.play("take_damage")
				var knockback_vector = (enemyPos - position).normalized() * knockbackDistance
				var knockback_target = position - knockback_vector
				var tween = $Tween
				tween.interpolate_property(self, "position", position, knockback_target, knockbackDuration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.start()
				motion = Vector2(0,0)
			else:
				animation_player.play("take_damage")
				_change_state(IDLE)

		DEAD:
			queue_free()

func take_damage(count):
	if current_state == DEAD:
		return
	health -= count
	Global.PlayerHealth.update_health(health)
	if health <= 0:
		health = 0
		_change_state(DEAD)
		return
	_change_state(STAGGER)

func heal(count):
	if health < max_health:
		health += count
		Global.PlayerHealth.update_health(health)

	#at the end of the damage animation goes back to idle
func _on_AnimationPlayer_animation_finished( name ):
	if name == "take_damage":
		_change_state(IDLE)

func _on_Weapon_attack_finished():
	_change_state(IDLE)
