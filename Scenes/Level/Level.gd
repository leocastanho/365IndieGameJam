extends Node2D

func _ready():
	if Global.love_stone_unlocked and Global.family_stone_unlocked and Global.spirit_stone_unlocked and Global.friendship_stone_unlocked:
		$dialogue_system.wich_area = $dialogue_system.WICHAREA.FINALAREA
		$dialogue_system.dialogue_count = 0
		$dialogue_system._on_NextButton_pressed()
		$dialogue_system.pop_up_show()
		var final_portal = Global.porta_final_area.instance()
		$Position2D.add_child(final_portal)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginAnim":
		$dialogue_system.pop_up_show()