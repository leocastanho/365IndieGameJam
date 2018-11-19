extends KinematicBody2D

var health
export var max_health = 5

func _ready():
	health = max_health

func take_damage(count):
	health -= count
	print (health)
	if health <= 0:
		health = 0
		queue_free()