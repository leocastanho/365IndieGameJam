"""
The stagger state end with the stagger animation from the AnimationPlayer
The animation only affects the Body Sprite"s modulate property so 
it could stack with other animations if we had two AnimationPlayer nodes
"""
extends "../state.gd"

export var knockbackDuration = 0.2
export var knockbackDistance = 50
var enemyPos = Vector2()
onready var player = get_node("../..")

func enter():
	owner.get_node("AnimationPlayer").play("stagger")
	#Knockback
	var knockback_vector = (enemyPos - player.global_position).normalized() * knockbackDistance
	var knockback_target = player.global_position - knockback_vector
	var tween = get_node("../../Tween")
	tween.interpolate_property(player, "position", player.global_position, knockback_target, knockbackDuration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()

func _on_animation_finished(anim_name):
	print("finished stagger")
	emit_signal("finished", "idle")
