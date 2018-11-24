extends Node2D

func _on_AnimationPlayer_animation_finished(anim_name):
	$dialogue_system.pop_up_show()
