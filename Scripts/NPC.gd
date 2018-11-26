extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(int) var life

var died = false
var canDamage = true
var friends_death = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$LifeBar.max_value = life
	$LifeBar.value = life
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if(isDied() && !died):
		$AnimationPlayer.play("Die")
		died = true
		
		
	pass
	
func isDied():
	if(life <= 0):
		return true
	
	return false

func take_Damage(value):
	
	if(canDamage):
		life -= value
		$LifeBar.value = life
	
	pass

func activate_dont_damage():
	canDamage = false

func friends_death_equals_game_over():
	friends_death = true

func _on_NPC_body_entered(body):

	if(body.is_in_group("Bullet") && !died):
		$AnimationPlayer.play("Take_Damage")
		take_Damage(body.damage)
		body.queue_free()
	
	pass # replace with function body


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if(anim_name == "Die"):
		if friends_death:
			if get_tree().get_current_scene().name == "Level4":
				Global.shield_of_friendship_unlock = false
				Global.staff_of_rottenness_unlock = false
			get_tree().reload_current_scene()
		queue_free()
	
	pass # replace with function body
