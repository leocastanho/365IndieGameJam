extends Control

signal health_changed(health)
onready var health_node = get_node("../../PlayerV2/Health")

func _ready(): 
	#passes the players max_health to the lifebar
	$Bars/LifeBar.initialize(health_node.max_health)

func _on_Health_health_changed(health):
	#emit signal to LifeBar
	emit_signal("health_changed", health)