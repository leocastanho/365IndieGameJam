extends Control

signal health_changed(health)
var health_node

func initialize(): 
	health_node = get_node("/root/Level/YSort/PlayerV2/Health")
	#passes the players max_health to the lifebar
	$Bars/LifeBar.initialize(health_node.max_health)

func _on_Health_health_changed(health):
	#emit signal to LifeBar
	emit_signal("health_changed", health)