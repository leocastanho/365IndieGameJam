extends Node

enum languages {PORTUGUESE, ENGLISH}
var language_on

#Global variables
var Player
var player_position = null
var item_list
var state_move
var dialogue_system_script
var begin_anim_once = false

#levels paths -> need to change manually
var initial_level = "res://Scenes/Level/Level.tscn"
var level1 = "res://Scenes/Level/Level1.tscn"
var level2 = "res://Scenes/Level/Level2.tscn"
var level3 = "res://Scenes/Level/Level3.tscn"
var level4 = "res://Scenes/Level/Level4.tscn"
var final_area
var porta_final_area = preload ("res://Scenes/Level/PortalFinalArea.tscn")

#dialogues path -> need to change manually
var dialogue_system = "res://interface/dialogue_system/dialogue_system.json"
var buttons = "res://interface/dialogue_system/buttons.json"

#stones paths -> need to change manually
#var love_stone = preload("res://stones/LoveStone.tscn")
var love_stone_texture = preload("res://interface/bar/stones_bar/LoveStone.png")
#var family_stone = preload("res://stones/FamilyStone.tscn")
var family_stone_texture = preload("res://interface/bar/stones_bar/FamilyStone.png")
#var spirit_stone = preload("res://stones/SpiritStone.tscn")
var spirit_stone_texture = preload("res://interface/bar/stones_bar/SpiritStone.png")
#var friendship_stone = preload("res://stones/FriendshipStone.tscn")
var friendship_stone_texture = preload("res://interface/bar/stones_bar/FriendshipStone.png")

#stones saves
var love_stone_unlocked = false
var family_stone_unlocked = false
var spirit_stone_unlocked = false
var friendship_stone_unlocked = false

#itens paths -> need to change manually
#area1
var sword_of_love = preload("res://player/weapon/Sword_of_Love.tscn")
var sword_of_love_texture = preload("res://player/itens/Espada-do-amor.png")
var freedom_cape = preload("res://player/itens/FreedomCape.tscn")
var freedom_cape_texture = preload("res://player/itens/Capa-Dash.png")
#area2
var life_potion = preload("res://player/itens/LifePotion.tscn")
var flife_potion_texture = preload("res://player/itens/Poção-1.png")
#area3
var speed_boots = preload("res://player/itens/SpeedBoots.tscn")
var speed_boots_texture = preload("res://player/itens/Bota-da-agilidade.png")
var time_potion = preload("res://player/itens/TimePotion.tscn")
var time_potion_texture = preload("res://player/itens/Poção-2.png")
var key_count = 0
var key_texture = preload("res://Art/Key_Gold.png")
var lightON = true
#area4
var staff_of_rottenness = preload("res://player/itens/StaffOfRottenness.tscn")
var staff_of_rottenness_texture = preload("res://player/itens/Cajado-podre.png")
var shield_of_friendship = preload("res://player/itens/ShieldOfFriendShip.tscn")
var shield_of_friendship_texture = preload("res://player/itens/Escudo-da-amizade.png")

#itens saves
#area1
var sword_of_love_unlock = false
var freedom_cape_unlock = false
#area2
var life_potion_unlock = false
#area3
var speed_boots_unlock = false
var time_potion_unlock = false
#area4
var staff_of_rottenness_unlock = false
var shield_of_friendship_unlock = false

#monster paths -> need to change manually
#var semi_boss = preload("res://Scenes/MonsterRangedSemiBoss.tscn")

#Stream paths -> need to change manually
#PLAYER
#var playerAttacking = preload("")
#var playerWalking = preload("")
#var playerTakingDamage = preload("")
#var playerHealing = preload("") 
#var playerDashing = preload("") 