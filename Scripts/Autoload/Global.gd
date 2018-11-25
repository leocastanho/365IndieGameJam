extends Node

enum languages {PORTUGUESE, ENGLISH}
var language_on

#Global variables
var Player
var PlayerHealth
var Weapon
var Interface
var item_list
var state_move
var dialogue_system_script

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
#area1
var sword_of_love = preload("res://player/weapon/Sword_of_Love.tscn")
var sword_of_love_texture = preload("res://Art/timepotion.png")
var freedom_cape = preload("res://player/itens/FreedomCape.tscn")
var freedom_cape_texture = preload("res://Art/timepotion.png")
#area2
var life_potion = preload("res://player/itens/LifePotion.tscn")
#area3
var time_potion = preload("res://player/itens/TimePotion.tscn")
var time_potion_texture = preload("res://Art/timepotion.png")
var speed_boots = preload("res://player/itens/SpeedBoots.tscn")
var speed_boots_texture = preload("res://Art/timepotion.png")
var key_count = 0
var key_texture = preload("res://Art/Key_Gold.png")
var lightON = true
#area4
var staff_of_rottenness = preload("res://player/bullet/PoisonBullet.tscn")
var shield_of_friendship =preload("res://player/itens/ShieldOfFriendShip.tscn")


#monster paths -> need to change manually
#var semi_boss = preload("res://Scenes/MonsterRangedSemiBoss.tscn")

#Stream paths -> need to change manually
#PLAYER
#var playerAttacking = preload("")
#var playerWalking = preload("")
#var playerTakingDamage = preload("")
#var playerHealing = preload("") 
#var playerDashing = preload("") 