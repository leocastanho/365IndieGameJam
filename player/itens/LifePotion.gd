extends Node

onready var health_node = get_node("../Health")

export var new_max_health = 14

func _ready():
	var life_bar = get_node("/root/Level/PlayerInterface/Interface/Bars/LifeBar/BarsContainers/Container")
	life_bar.get_node("AnimationPlayer").play("stretch_life_bar")
	life_bar.get_node("TextureProgress").max_value = new_max_health
	life_bar.get_node("TextureProgress").value = new_max_health
	health_node.max_health = new_max_health
	health_node.health = new_max_health
#	if health_node.health < health_node.max_health:
#		$HealCD.start()
#
#func heal():
#	if $HealCD.is_stopped() and health_node.health < health_node.max_health:
#		$HealCD.start()
#
#func _on_HealCD_timeout():
#	health_node.heal(1)
#	heal()
