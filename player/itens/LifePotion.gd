extends Node

func _ready():
	$HealCD.start()

func _on_HealCD_timeout():
	get_node("../Health").heal(1)
	$HealCD.start()
