"""
The stagger state end with the stagger animation from the AnimationPlayer
The animation only affects the Body Sprite"s modulate property so 
it could stack with other animations if we had two AnimationPlayer nodes
"""
extends "../state.gd"

func enter():
	owner.get_node("AnimationPlayer").play("idle")
	get_node("../../ShakingCamera").shake = true

func _on_Sword_attack_finished():
	print("eita giocana")
	emit_signal("finished", "previous")
