extends Area2D

const DamageSource = preload("res://player/DamageSource.gd")

func _on_area_entered(area):
	if not area is DamageSource:
		return
	owner.take_damage_from(area,area.damage,null)

func set_active(value):
	$CollisionShape2D.disabled = not value
