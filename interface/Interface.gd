extends Control

signal health_changed(health)

#func initialize(max_health): 
#	#passes the players max_health to the lifebar
#	$Bars/LifeBar.initialize(max_health)

func _on_Health_health_changed(health):
	#emit signal to LifeBar
	emit_signal("health_changed", health)