extends "state.gd"


# Initialize the state. E.g. change the animation
func enter():
	owner.set_dead(true)
	owner.visible = false
	owner.get_node("AnimationPlayer").play("die")

func _on_animation_finished(anim_name):
	owner.visible = false
