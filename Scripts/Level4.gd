extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var isAreaFinish = false
var timePassed = 0
export var timeReload = 3
var can_shoot = false

func _ready():
	var array = $YSort/Monsters.get_children()
	for i in range(0, array.size()):
		array[i].set_physics_process(false)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if can_shoot and not isAreaFinish:
		timePassed += delta
	#	timePassed = timeReload
		if(timePassed > timeReload):
			make_monsters_shoot()
	
	$TimerInterface/Interface.text = str(int($Timer.time_left))
	
	
	if($YSort/Monsters.get_child_count() == 0 && !isAreaFinish):
		$dialogue_system.area4_after_protect_interation("optionB")
		Global.Player.unlock_object_anim(Global.friendship_stone_texture)
		isAreaFinish = true
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func make_monsters_shoot():
	var rand = randi() % 6 + 1
	if rand == 1:
		if $YSort/Monsters/MonsterRanged != null:
			get_tree().call_group("Monster1","shoot")
		else:
			make_monsters_shoot()
	if rand == 2:
		if $YSort/Monsters/MonsterRanged2 != null:
			get_tree().call_group("Monster2","shoot")
		else:
			make_monsters_shoot()
	if rand == 3:
		if $YSort/Monsters/MonsterRanged3 != null:
			get_tree().call_group("Monster3","shoot")
		else:
			make_monsters_shoot()
	if rand == 4:
		if $YSort/Monsters/MonsterRanged4 != null:
			get_tree().call_group("Monster4","shoot")
		else:
			make_monsters_shoot()
	if rand == 5:
		if $YSort/Monsters/MonsterRanged5 != null:
			get_tree().call_group("Monster5","shoot")
		else:
			make_monsters_shoot()
	if rand == 6:
		if $YSort/Monsters/MonsterRanged6 != null:
			get_tree().call_group("Monster6","shoot")
		else:
			make_monsters_shoot()
	timePassed = 0

func startAGame(option):
	if(option == "OptionA"):
		timeReload = 3
		var timer = $Timer
		timer.wait_time = 30
		timer.start()
		var timerInterface = $TimerInterface/Interface
		timerInterface.text = str(timer.time_left)
		timerInterface.show()
#		get_node("YSort/NPC").activate_dont_damage()
		get_node("YSort/NPC").friends_death_equals_game_over()
		can_shoot = true
		
		var array = $YSort/Monsters.get_children()
		for i in range(0, array.size()):
			array[i].set_physics_process(true)
			array[i].activate_dont_damage()
			
	elif(option == "OptionB"):
		timeReload = 1
		var array = $YSort/Monsters.get_children()
		for i in range(0, array.size()):
			array[i].set_physics_process(true)
			array[i].activate_damage()
		can_shoot = true

func _on_Timer_timeout():
	isAreaFinish = true
	Global.Player.unlock_object_anim(Global.friendship_stone_texture)
	$dialogue_system.area4_after_protect_interation("optionA")
	$TimerInterface/Interface.hide()
	
	var array = $YSort/Monsters.get_children()
	for i in range(0, array.size()):
			array[i].set_physics_process(false)
			
	pass # replace with function body
