extends Node2D

func _ready():
	if Global.love_stone_unlocked and Global.family_stone_unlocked and Global.family_stone_unlocked and Global.friendship_stone_unlocked:
		var final_portal = Global.porta_final_area.instance()
		$Position2D.add_child(final_portal)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginAnim":
		$dialogue_system.pop_up_show()