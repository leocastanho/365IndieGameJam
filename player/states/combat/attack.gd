"""
The stagger state end with the stagger animation from the AnimationPlayer
The animation only affects the Body Sprite"s modulate property so 
it could stack with other animations if we had two AnimationPlayer nodes
"""
extends "../state.gd"

onready var shaking_camera = get_node("../../ShakingCamera")

func enter():
	owner.get_node("AnimationPlayer").play("idle")
#	if Global.Player.has_node("WeaponPivot/Offset/sword_of_love"):
##		shaking_camera.
#	shaking_camera.shake = true

func _on_Sword_attack_finished():
	emit_signal("finished", "previous")
