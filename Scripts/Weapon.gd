extends Area2D

signal attack_finished

onready var animation_player = $AnimationPlayer

enum STATES {IDLE, ATTACK}
var current_state = IDLE

export(int) var damage = 1


func _ready():
	set_physics_process(false)
	Global.Weapon = self


func attack():
	_change_state(ATTACK)


func _change_state(new_state):
	current_state = new_state

	match current_state:
		IDLE:
			set_physics_process(false)
			$CollisionShape2D.disabled = true
		ATTACK:
			set_physics_process(true)
			$CollisionShape2D.disabled = false
			animation_player.play("attack")

func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
	# For each body, check if it's an enemy
	for body in overlapping_bodies:
		if not body.is_in_group("character"):  #fix this later with this every npc will have to be on this group
			return
	#if the body is the playe, it wont hit him
		if is_owner(body):
			return
#	# If it is a enemy, damage it and stop physics process for this attack
#	# Otherwise it damages targets on every tick
		body.take_damage(damage)  #all the enemies need this function, its on character.gd
	set_physics_process(false)
	

func is_owner(body):
	# Return true if the node is the weapon's owner
	return body == Global.Player

# Write AnimationPlayer callback when the attack animation ends
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		_change_state(IDLE)
		emit_signal("attack_finished")
