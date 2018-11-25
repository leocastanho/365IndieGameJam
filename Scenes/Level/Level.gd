extends Node2D

func _ready():
	get_node("/root/PlayerInterface/Interface").initialize()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginAnim":
		$dialogue_system.pop_up_show()

