extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var chooseOption
var isAreaFinish = false

func _ready():
	
	$YSort/Mother.set_process(false)
	$YSort/Father.set_process(false)
	
	var arrMother = $YSort/MotherSide.get_children()
	for i in range(0, arrMother.size()):
		arrMother[i].set_physics_process(false)
		arrMother[i].activate_dont_damage()
		
	var arrFather = $YSort/FatherSide.get_children()
	for i in range(0, arrFather.size()):
		arrFather[i].set_physics_process(false)
		arrFather[i].activate_dont_damage()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func startAGame(option):
	
	var arrMother = $YSort/MotherSide.get_children()
	for i in range(0, arrMother.size()):
		arrMother[i].set_physics_process(true)
		arrMother[i].activate_damage()
		
	var arrFather = $YSort/FatherSide.get_children()
	for i in range(0, arrFather.size()):
		arrFather[i].set_physics_process(true)
		arrFather[i].activate_damage()
	
	if(option == "OptionA"):
		for i in range(0, arrMother.size()):
			arrMother[i].activate_dont_damage()
			arrMother[i].get_node("HealthBar").hide()
			arrMother[i].get_node("DamageSource").queue_free()
		
	elif(option == "OptionB"):
		for i in range(0, arrFather.size()):
			arrFather[i].activate_dont_damage()
			arrFather[i].get_node("HealthBar").hide()
			arrFather[i].get_node("DamageSource").queue_free()
	
	$YSort/Mother.set_process(true)
	$YSort/Father.set_process(true)
	
	$TimerInterface/Interface.hide()
	$Timer.stop()
	
	chooseOption = option

func finishGame():
	$YSort/Mother.set_physics_process(false)
	$YSort/Father.set_physics_process(false)
	
	if(chooseOption != "OptionA" && chooseOption != "OptionB"):
		var arrMother = $YSort/MotherSide.get_children()
		for i in range(0, arrMother.size()):
			arrMother[i].activate_dont_damage()
			arrMother[i].get_node("HealthBar").hide()
			arrMother[i].get_node("DamageSource").queue_free()
			
		var arrFather = $YSort/FatherSide.get_children()
		for i in range(0, arrFather.size()):
			arrFather[i].activate_dont_damage()
			arrFather[i].get_node("HealthBar").hide()
			arrFather[i].get_node("DamageSource").queue_free()
		
	isAreaFinish = true

func _process(delta):
	
	if(!isAreaFinish):
		$TimerInterface/Interface.text = str(int($Timer.time_left))
		
		if(chooseOption == "OptionA"):
			if($YSort/FatherSide.get_child_count() == 0):
				$dialogue_system.area2_after_family_interation("optionA")
				finishGame()
		elif(chooseOption == "OptionB"):
			if($YSort/MotherSide.get_child_count() == 0):
				$dialogue_system.area2_after_family_interation("optionA")
				finishGame()
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass


func _on_Timer_timeout():
	finishGame()
	#Global.Player.unlock_stone_anim(Global.family_stone_texture)
	$dialogue_system.area2_after_family_interation("optionB")
	$dialogue_system.hide_option()
	$TimerInterface/Interface.hide()
	
	pass # replace with function body


func _on_DialogueTrigger_body_entered(body):
	$Timer.wait_time = 20
	$Timer.start()
	$TimerInterface/Interface.show()
	
	pass # replace with function body
