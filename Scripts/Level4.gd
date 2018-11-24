extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var isAreaFinish = false

func _ready():
	var array = $YSort/Monsters.get_children()
	for i in range(0, array.size()):
		array[i].set_physics_process(false)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	$TimerInterface/Interface.text = str(int($Timer.time_left))
	
	
	if($YSort/Monsters.get_child_count() == 0 && !isAreaFinish):
		$dialogue_system.area4_after_protect_interation("optionA")
		Global.Player.unlock_object_anim(Global.friendship_stone_texture)
		isAreaFinish = true
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func startAGame(option):
	if(option == "OptionA"):
		var timer = $Timer
		timer.wait_time = 10
		timer.start()
		var timerInterface = $TimerInterface/Interface
		timerInterface.text = str(timer.time_left)
		timerInterface.show()
		get_node("YSort/NPC").activate_dont_damage()
		
		var array = $YSort/Monsters.get_children()
		for i in range(0, array.size()):
			array[i].set_physics_process(true)
			array[i].activate_dont_damage()
			
	elif(option == "OptionB"):
		var array = $YSort/Monsters.get_children()
		for i in range(0, array.size()):
			array[i].set_physics_process(true)
			array[i].activate_damage()

func _on_Timer_timeout():
	isAreaFinish = true
	Global.Player.unlock_object_anim(Global.friendship_stone_texture)
	$dialogue_system.area4_after_protect_interation("optionB")
	$TimerInterface/Interface.hide()
	
	var array = $YSort/Monsters.get_children()
	for i in range(0, array.size()):
			array[i].set_physics_process(false)
	pass # replace with function body
