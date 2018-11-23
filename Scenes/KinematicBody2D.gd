extends KinematicBody2D

func take_damage(damage_dealer,damage,effect):
	print("chegou aqui")
	$Health.take_damage(damage,effect)