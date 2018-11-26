extends Control

signal health_changed(health)

#func initialize(max_health): 
#	#passes the players max_health to the lifebar
#	$Bars/LifeBar.initialize(max_health)

func _on_Health_health_changed(health):
	#emit signal to LifeBar
	emit_signal("health_changed", health)


func _on_PanicButton_pressed():
	if get_tree().get_current_scene().name == "Level1":
		Global.sword_of_love_unlock = false
		Global.freedom_cape_unlock = false
		get_tree().reload_current_scene()
	if get_tree().get_current_scene().name == "Level2":
		Global.life_potion_unlock = false
		get_tree().reload_current_scene()
	if get_tree().get_current_scene().name == "Level3":
		Global.Player.position = Vector2(-100,-10)
	if get_tree().get_current_scene().name == "Level4":
		Global.shield_of_friendship_unlock = false
		Global.staff_of_rottenness_unlock = false
		get_tree().reload_current_scene()

