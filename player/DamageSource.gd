extends Area2D

export(int) var damage = 2
export(preload("res://Scripts/Autoload/global_constants.gd").STATUSES) var effect

func set_active(value):
	$CollisionShape2D.disabled = not value
