extends Node

enum languages {PORTUGUESE, ENGLISH}
var language_on

#Global variables
var Player
var PlayerHealth
var Weapon
var Interface

#dialogues path -> need to change manually
var dialogue_system = "res://interface/dialogue_system/dialogue_system.json"
var buttons = "res://interface/dialogue_system/buttons.json"

#stones paths -> need to change manually
var love_stone = preload("res://stones/LoveStone.tscn")
var love_stone_texture = preload("res://interface/bar/stones_bar/LoveStone.png")
var family_stone = preload("res://stones/FamilyStone.tscn")
var family_stone_texture = preload("res://interface/bar/stones_bar/FamilyStone.png")
var spirit_stone = preload("res://stones/SpiritStone.tscn")
var spirit_stone_texture = preload("res://interface/bar/stones_bar/SpiritStone.png")
var friendship_stone = preload("res://stones/FriendshipStone.tscn")
var friendship_stone_texture = preload("res://interface/bar/stones_bar/FriendshipStone.png")

#itens paths -> need to change manually
var sword_of_love = preload("res://player/weapon/Sword_of_Love.tscn")
var freedom_cape = preload("res://player/itens/FreedomCape.tscn")

#monster paths -> need to change manually
#var semi_boss = preload("res://Scenes/MonsterRangedSemiBoss.tscn")

#Stream paths -> need to change manually
#PLAYER
#var playerAttacking = preload("")
#var playerWalking = preload("")
#var playerTakingDamage = preload("")
#var playerHealing = preload("") 
#var playerDashing = preload("") 