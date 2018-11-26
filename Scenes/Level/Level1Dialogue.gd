extends Node2D

func _ready():
	$dialogue_system.pop_up_show()
	get_node("/root/PlayerInterface/Interface").visible = false