extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum WHERE {CENTER, RIGHT, LEFT, TOP, DOWN}

onready var slimeGreen = preload("res://Scenes/Monsters/Slimes/GreenSlime.tscn")
onready var slimeBlue = preload("res://Scenes/Monsters/Slimes/BlueSlime.tscn")
onready var slimeOrange = preload("res://Scenes/Monsters/Slimes/OrangeSlime.tscn")
onready var slimeRed = preload("res://Scenes/Monsters/Slimes/RedSlime.tscn")


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func spawnEasy():
	
	var pEasy = $YSort/Boss/PHASES/EASY.get_children()
	for i in range(0, pEasy.size()):
		var newInstance = slimeGreen.instance()
		newInstance.position = pEasy[i].global_position
		$YSort/Monsters.add_child(newInstance)
	
	pass
	
func spawnNormal():
	
	var pNormal = $YSort/Boss/PHASES/NORMAL.get_children()
	for i in range(0, pNormal.size()):
		var newInstance = slimeBlue.instance()
		newInstance.position = pNormal[i].global_position
		$YSort/Monsters.add_child(newInstance)
	
	pass
	
func spawnHard():
	
	var pHard = $YSort/Boss/PHASES/HARD.get_children()
	for i in range(0, pHard.size()):
		var newInstance = slimeOrange.instance()
		newInstance.position = pHard[i].global_position
		$YSort/Monsters.add_child(newInstance)
	
	pass
	
func spawnMaster():
	
	var pMaster = $YSort/Boss/PHASES/MASTER.get_children()
	for i in range(0, pMaster.size()):
		var newInstance = slimeRed.instance()
		newInstance.position = pMaster[i].global_position
		$YSort/Monsters.add_child(newInstance)
	
	pass

func whereTeleport(new_where):
	
	match new_where:
		CENTER:
			$YSort/Boss.position = $Teleport/Center.global_position
			pass
		RIGHT:
			$YSort/Boss.position = $Teleport/Right.global_position
			pass
		LEFT:
			$YSort/Boss.position = $Teleport/Left.global_position
			pass
		TOP:
			$YSort/Boss.position = $Teleport/Top.global_position
			pass
		DOWN:
			$YSort/Boss.position = $Teleport/Down.global_position
			pass
	
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
