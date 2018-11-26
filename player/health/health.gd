extends Node

#must connect with interface
signal health_changed
#must connect with interface
signal health_depleted
signal status_changed

var health = 0
export(int) var max_health = 9
var health_GUI

var status = null
const POISON_DAMAGE = 1
var poison_cycles = 4
var stun_cycles = 4

func _ready():
	health = max_health
	print(health)
	if owner.get_name() == "PlayerV2":
		if Global.life_potion_unlock:
			max_health = 14
			health = max_health
		connect("health_changed",get_node("/root/PlayerInterface/Interface"),"_on_Health_health_changed")
#		get_node("/root/PlayerInterface/Interface").initialize(max_health)
		#emit signal to Interface
		emit_signal("health_changed", health)
		pass
	else:
		health_GUI = owner.get_node("HealthBar")
		if(!health_GUI):
			health_GUI = owner.get_node("CanvasLayer/Back/HealthBar")
	$PoisonTimer.connect('timeout', self, '_on_PoisonTimer_timeout')
	$StunTimer.connect('timeout', self, '_on_StunTimer_timeout')
	$MiniStunTimer.connect('timeout', self, '_on_MiniStunTimer_timeout')


func _process(delta):
#	health_GUI.rect_rotation = - get_node("../").rotation_degrees
	pass

func _change_status(new_status):
	match status:
		global_constants.STATUS_POISONED:
			$PoisonTimer.stop()
		global_constants.STATUS_STUNNED:
			$StunTimer.stop()

	match new_status:
		global_constants.STATUS_POISONED:
#			poison_cycles = 4
			$PoisonTimer.start()
		global_constants.STATUS_STUNNED:
			$StunTimer.start()
	status = new_status
#	emit_signal('status_changed', new_status)

func take_damage(amount, effect=null):
	if status == global_constants.STATUS_INVINCIBLE:
		return
	health -= amount
	health = max(0, health)
	if owner.get_name() == "PlayerV2":
		#emit signal to Interface
		emit_signal("health_changed", health)
#		if Global.Player.has_node("LifePotion"):
#			Global.Player.get_node("LifePotion").heal()
	else:
		health_GUI.value = float(health)/float(max_health) * health_GUI.max_value
	if health <= 0:
		if owner.get_name() == "PlayerV2":
			owner.get_node("StateMachine/Stagger").emit_signal("finished", "dead")
			if get_tree().get_current_scene().name == "Level1":
				Global.sword_of_love_unlock = false
				Global.freedom_cape_unlock = false
			if get_tree().get_current_scene().name == "Level2":
				pass
			if get_tree().get_current_scene().name == "Level3":
				Global.speed_boots_unlock = false
				Global.time_potion_unlock = false
			if get_tree().get_current_scene().name == "Level4":
				Global.shield_of_friendship_unlock = false
				Global.staff_of_rottenness_unlock = false
			get_tree().reload_current_scene()
		else:
			if owner.name == "MonsterRangedSemiBoss":
				owner.set_physics_process(false)
				if not owner.get_node("AnimationPlayer").get_current_animation() == "death":
					owner.get_node("AnimationPlayer").play("death")
			elif (owner.is_in_group("Monsters")):
				owner.died()
				owner.set_physics_process(false)
			else:
				owner.queue_free()

	if not effect:
		return
	match effect:
		global_constants.STATUS_POISONED:
			print("poison")
			_change_status(global_constants.STATUS_POISONED)
#			poison_cycles = effect[1]
		global_constants.STATUS_STUNNED:
			print("stuned")
			if owner.get_name() == "PlayerV2":
				_change_status(global_constants.STATUS_STUNNED)
#	print("%s got hit and took %s damage. Health: %s/%s" % [get_name(), amount, health, max_health])

func heal(amount):
	health += amount
	health = max(health, max_health)
	if owner.get_name() == "PlayerV2":
		#emit signal to Interface
		emit_signal("health_changed", health)
	else:
		health_GUI.value = float(health)/float(max_health) * health_GUI.max_value
#	print("%s got healed by %s points. Health: %s/%s" % [get_name(), amount, health, max_health])

func _on_PoisonTimer_timeout():
	print("poisoncycle")
	take_damage(POISON_DAMAGE)
	poison_cycles -= 1
	if poison_cycles == 0:
		_change_status(global_constants.STATUS_NONE)
		return
	$PoisonTimer.start()
	
func _on_StunTimer_timeout():
	print (stun_cycles)
	stun_cycles -= 1
	owner.get_node("StateMachine/Move").emit_signal("finished", "stagger")
	if stun_cycles == 0:
		_change_status(global_constants.STATUS_NONE)
		return
	$StunTimer.start()

func _on_MiniStunTimer_timeout():
	owner.get_node("StateMachine/Stagger").emit_signal("finished", "move")