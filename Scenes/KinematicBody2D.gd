extends KinematicBody2D

var health
export var max_health = 5

func _ready():
	health = max_health

func take_damage(damage_dealer,damage,effect):
	health -= damage
	print (health)
	if health <= 0:
		health = 0
		queue_free()