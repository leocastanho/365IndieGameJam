extends Area2D

var health = 5
var damage = 1

func take_damage(count):
	health -= count
	print(health)
	if health <= 0:
		health = 0
		queue_free()

func _on_Area2D_body_entered(body):
#	if body == Global.Player:
#		Global.Player.take_damage(1)
#	body.take_damage(self, 1, null)
#	var stagger = body.get_node("StateMachine/Stagger")
#	stagger.enemyPos = position
	pass

func _on_Area2D_area_entered(area):
	take_damage(Global.Weapon.damage)
