# Manages a character's health and death. Used by the UI to draw lifebars on any character or enemy
extends Node

var currentHealth
var max_health

#func _ready():
#	if is_in_group("PlayerHealth"):
#		currentHealth = Global.PlayerHealth.max_health
#		max_health = Global.PlayerHealth.max_health

func update_health(health):
	currentHealth = health
	var healthRatio = float(currentHealth)/float(max_health)
	self.value = healthRatio * self.max_value
