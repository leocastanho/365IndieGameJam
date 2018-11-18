extends Area2D

var health = 5

func take_damage(count):
	health -= count
	print(health)
	if health <= 0:
		health = 0
		queue_free()

func _on_Area2D_body_entered(body):
	if body == Global.Player:
		Global.Player.take_damage(1)
		Global.Player.enemyPos = position

func _on_Area2D_area_entered(area):
	take_damage(Global.Weapon.damage)
