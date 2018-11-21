extends Node

enum languages {PORTUGUESE, ENGLISH}
var language_on

#Global variables
var Player
var PlayerHealth
var Weapon

#path -> need to change manually
var dialogue_system = "res://interface/dialogue_system/dialogue_system.json"

#itens paths -> need to change manually
var sword_of_love = preload("res://player/weapon/Sword_of_Love.tscn")
var freedom_cape = preload("res://player/itens/FreedomCape.tscn")

#monster paths -> need to change manually

var semi_boss = preload("res://Scenes/MonsterRangedSemiBoss.tscn")

#Stream paths -> need to change manually
#PLAYER
#var playerAttacking = preload("")
#var playerWalking = preload("")
#var playerTakingDamage = preload("")
#var playerHealing = preload("") 
#var playerDashing = preload("") 