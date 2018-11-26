extends Area2D

func _ready():
	Global.Player.get_node("CanvasModulate/AnimationPlayer").play("idle")

func _on_PortalInitialArea_body_entered(body):
	if body == Global.Player and Global.love_stone_unlocked and get_node("../").name == "Level1":
		get_tree().change_scene(Global.initial_level)
	if body == Global.Player and Global.family_stone_unlocked and get_node("../").name == "Level2":
		get_tree().change_scene(Global.initial_level)
	if body == Global.Player and Global.spirit_stone_unlocked and get_node("../").name == "Level3":
		get_tree().change_scene(Global.initial_level)
	if body == Global.Player and Global.friendship_stone_unlocked and get_node("../").name == "Level4":
		get_tree().change_scene(Global.initial_level)
