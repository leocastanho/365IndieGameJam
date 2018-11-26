extends CanvasLayer

var dialogue_count = 0
enum dialogue_part {NORMALDIALOGUE, DIALOGUEA, DIALOGUEAFINAL, DIALOGUEB, DIALOGUEBFINAL}
var dialogue
var buttons
enum WICHAREA {INITIALAREA, MINDAREA1, AREA1, MINDAREA2, AREA2, MINDAREA3, AREA3, MINDAREA4 AREA4, FINALAREA}
export(WICHAREA) var wich_area = WICHAREA.INITIALAREA
var area_for_buttonB
var language_for_area2
var time_button_area2_pressed = 0

func _ready():
	dialogue = get_from_json(Global.dialogue_system)
	buttons = get_from_json(Global.buttons)
	if Global.language_on == Global.ENGLISH:
		$Popup/DialogueBox/NextButton/Label.text = buttons[0]["next"][0]
		language_for_area2 = 0
	elif Global.language_on == Global.PORTUGUESE:
		$Popup/DialogueBox/NextButton/Label.text = buttons[1]["next"][0]
		language_for_area2 = 1
	dialogue_part = NORMALDIALOGUE
	_on_NextButton_pressed()

func get_from_json(filename):
	var file = File.new() #the file object
	file.open(filename,File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func _on_NextButton_pressed():
	if Global.language_on == Global.ENGLISH:
		match wich_area:
			INITIALAREA:
				wich_area(0, "initial_area")
			MINDAREA1:
				wich_area(0, "mind_area1")
			AREA1:
				wich_area_button(0, "option1A", "option1B", "close1A", "close1B")
				wich_dialogue(0, "area1", "area1A", "area1AFinal", "area1B", "area1BFinal")
			MINDAREA2:
				wich_area(0, "mind_area2")
			AREA2:
				wich_area_button(0, "option2A", "option2B", "close2A", "close2B")
				wich_dialogue(0, "area2", "area2A", "area2AFinal", "area2B", "area2BFinal")
			MINDAREA3:
				wich_area(0, "mind_area3")
			AREA3:
				wich_area_button(0, "option3A", "option3B", "close3A", "close3B")
				wich_dialogue(0, "area3", "area3A", "area3AFinal", "area3B", "area3BFinal")
			MINDAREA4:
				wich_area(0, "mind_area4")
			AREA4:
				wich_area_button(0, "option4A", "option4B", "close4A", "close4B")
				wich_dialogue(0, "area4", "area4A", "area4AFinal", "area4B", "area4BFinal")
			FINALAREA:
				wich_area(0, "final_area")
	elif Global.language_on == Global.PORTUGUESE:
		match wich_area:
			INITIALAREA:
				wich_area(1, "initial_area")
			MINDAREA1:
				wich_area(1, "mind_area1")
			AREA1:
				wich_area_button(1, "option1A", "option1B", "close1A", "close1B")
				wich_dialogue(1, "area1", "area1A", "area1AFinal", "area1B", "area1BFinal")
			MINDAREA2:
				wich_area(1, "mind_area2")
			AREA2:
				wich_area_button(1, "option2A", "option2B", "close2A", "close2B")
				wich_dialogue(1, "area2", "area2A", "area2AFinal", "area2B", "area2BFinal")
			MINDAREA3:
				wich_area(1, "mind_area3")
			AREA3:
				wich_area_button(1, "option3A", "option3B", "close3A", "close3B")
				wich_dialogue(1, "area3", "area3A", "area3AFinal", "area3B", "area3BFinal")
			MINDAREA4:
				wich_area(1, "mind_area4")
			AREA4:
				wich_area_button(1, "option4A", "option4B", "close4A", "close4B")
				wich_dialogue(1, "area4", "area4A", "area4AFinal", "area4B", "area4BFinal")
			FINALAREA:
				wich_area(1, "final_area")
	dialogue_count += 1

func wich_area(language, area):
	area_for_buttonB = area
	dialogue_count = clamp(dialogue_count, 0, dialogue[language][area].size() - 1)
	$Popup/DialogueBox/Label.text = dialogue[language][area][dialogue_count]
	if area == "initial_area":
		if dialogue_count == dialogue[0]["initial_area"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false
	if area == "mind_area1":
		if dialogue_count == dialogue[0]["mind_area1"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false
	if area == "mind_area2":
		if dialogue_count == dialogue[0]["mind_area2"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false
	if area == "mind_area3":
		if dialogue_count == dialogue[0]["mind_area3"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false
	if area == "mind_area4":
		if dialogue_count == dialogue[0]["mind_area4"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false

func wich_dialogue(language, normal_dialogue, dialogue_a, final_dialogue_a, dialogue_b, final_dialogue_b):
	
				if dialogue_part == NORMALDIALOGUE:
					wich_area(language, normal_dialogue)
					if dialogue_count == dialogue[0][normal_dialogue].size() - 1:
						show_options()
						
				elif dialogue_part == DIALOGUEA:
					if dialogue_count == dialogue[0][dialogue_a].size() - 1:
						$Popup/DialogueBox/CloseButtonA.visible = true
						$Popup/DialogueBox/NextButton.visible= false
					wich_area(language, dialogue_a)
					
				elif dialogue_part == DIALOGUEAFINAL:
					if wich_area == AREA3:
						if dialogue_count == dialogue[0][final_dialogue_b].size() - 1:
							Global.Player.unlock_object_anim(Global.spirit_stone_texture)
					if dialogue_count == dialogue[0][final_dialogue_a].size():
						pop_up_hide()
					wich_area(language, final_dialogue_a)
					
				elif dialogue_part == DIALOGUEB:
					if not wich_area == AREA2:
						if dialogue_count == dialogue[0][dialogue_b].size() - 1:
							$Popup/DialogueBox/CloseButtonB.visible = true
							$Popup/DialogueBox/NextButton.visible= false
					else:
						if dialogue_count == 3 and time_button_area2_pressed == 0:
							Global.Player.unlock_object_anim(Global.family_stone_texture)
							$Popup/DialogueBox/CloseButtonFinal.visible = true
							$Popup/DialogueBox/NextButton.visible= false
						if dialogue_count == dialogue[0][dialogue_b].size() and time_button_area2_pressed >= 1:
							$Popup/DialogueBox/CloseButtonB.visible = true
							$Popup/DialogueBox/NextButton.visible= false
					wich_area(language, dialogue_b)
					
				elif dialogue_part == DIALOGUEBFINAL:
					if wich_area == AREA1:
						if dialogue_count == dialogue[0][final_dialogue_b].size() - 1:
							Global.Player.unlock_object_anim(Global.love_stone_texture)
					if wich_area == AREA3:
						if dialogue_count == dialogue[0][final_dialogue_b].size() - 1:
							Global.Player.unlock_object_anim(Global.spirit_stone_texture)
					if dialogue_count == dialogue[0][final_dialogue_b].size():
						pop_up_hide()
					wich_area(language, final_dialogue_b)

func wich_area_button(language, optionA, optionB, closeA, closeB):
	$Popup/DialogueBox/OptionA/Label.text = buttons[language][optionA][0]
	$Popup/DialogueBox/OptionB/Label.text = buttons[language][optionB][0]
	$Popup/DialogueBox/CloseButtonA/Label.text = buttons[language][closeA][0]
	$Popup/DialogueBox/CloseButtonB/Label.text = buttons[language][closeB][0]

func _on_OptionA_pressed():
	dialogue_part = DIALOGUEA
	match wich_area:
		AREA1:
			var sword = Global.sword_of_love.instance()
			Global.Player.get_node("WeaponPivot/Offset/Sword").queue_free()
			Global.Player.get_node("WeaponPivot/Offset").add_child(sword)
			Global.Player.unlock_object_anim(Global.sword_of_love_texture)
			Global.sword_of_love_unlock = true
		AREA2:
			if time_button_area2_pressed == 0:
				$Popup/DialogueBox/OptionA/Label.text = buttons[language_for_area2]["option2A"][1]
				$Popup/DialogueBox/OptionB/Label.text = buttons[language_for_area2]["option2B"][1]
				time_button_area2_pressed += 1
			elif time_button_area2_pressed >= 1:
#				get_node("..").startAGame("OptionA")
				hide_option()
				_on_NextButton_pressed()
		AREA3:
			pass
		AREA4:
			var shield = Global.shield_of_friendship.instance()
			Global.Player.get_node("WeaponPivot/Offset").add_child(shield)
			Global.Player.unlock_object_anim(Global.shield_of_friendship_texture)
			Global.shield_of_friendship_unlock = true
	if not wich_area == AREA2:
		hide_option()
		_on_NextButton_pressed()

func _on_OptionB_pressed():
	dialogue_part = DIALOGUEB
	match wich_area:
		AREA1:
			var cape = Global.freedom_cape.instance()
			Global.Player.add_child(cape)
			Global.Player.unlock_object_anim(Global.freedom_cape_texture)
			Global.freedom_cape_unlock = true
		AREA2:
			if time_button_area2_pressed == 0:
				var life_potion = Global.life_potion.instance()
				Global.Player.add_child(life_potion)
				Global.Player.unlock_object_anim(Global.flife_potion_texture)
				Global.life_potion_unlock = true
				get_node("..").finishGame()
				hide_option()
				_on_NextButton_pressed()
			elif time_button_area2_pressed >= 1:
#				get_node("..").startAGame("OptionB")
#				$Popup/DialogueBox/OptionA.visible = false
#				$Popup/DialogueBox/OptionB.visible = false
				hide_option()
				dialogue_count = 5
				_on_NextButton_pressed()
		AREA3:
			pass
		AREA4:
			var staff = Global.staff_of_rottenness.instance()
			Global.Player.add_child(staff)
			Global.Player.unlock_object_anim(Global.staff_of_rottenness_texture)
			Global.staff_of_rottenness_unlock = true
	if not wich_area == AREA2:
		hide_option()
		_on_NextButton_pressed()

func show_options():
	$Popup/DialogueBox/OptionA.visible = true
	$Popup/DialogueBox/OptionB.visible = true
	$Popup/DialogueBox/NextButton.visible = false

func hide_option():
	dialogue_count = 0
	$Popup/DialogueBox/OptionA.visible = false
	$Popup/DialogueBox/OptionB.visible = false
	$Popup/DialogueBox/NextButton.visible = true

func pop_up_show():
	$Tween.interpolate_property($Popup, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	$Popup.show()

func pop_up_hide():
	$Tween.interpolate_property($Popup, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	$Popup.hide()

func _on_CloseButtonA_pressed():
	pop_up_hide()
	$Popup/DialogueBox/CloseButtonA.visible = false
	$Popup/DialogueBox/CloseButtonB.visible = false
	dialogue_count = 0
	match wich_area:
		AREA1:
			#makes the girlfried start to shoot
			var semi_boss = get_node("../YSort/SemiBoss/MonsterRangedSemiBoss")
			semi_boss.set_physics_process(true)
			semi_boss.get_node("AnimationPlayer").play("normal_move", -1, 0.8)
			semi_boss.get_node("HealthBar").visible = true
			semi_boss.get_node("DamageSource/CollisionShape2D").disabled = false
			semi_boss.get_node("Collision").disabled = false
		AREA2:
			if time_button_area2_pressed >= 1:
				get_node("..").startAGame("OptionA")
#				hide_option()
#				_on_NextButton_pressed()
		AREA3:
			get_tree().call_group("DoorEasy","open_door")
		AREA4:
			#Start a game Level 4
			get_node("..").startAGame("OptionA")
			pass

func _on_CloseButtonB_pressed():
	pop_up_hide()
	$Popup/DialogueBox/CloseButtonA.visible = false
	$Popup/DialogueBox/CloseButtonB.visible = false
	dialogue_count = 0
	match wich_area:
		AREA1:
			#makes the girlfried start to shoot
			var semi_boss = get_node("../YSort/SemiBoss/MonsterRangedSemiBoss")
			semi_boss.set_physics_process(true)
			semi_boss.get_node("AnimationPlayer").play("normal_move", -1, 0.8)
			semi_boss.get_node("RunTimer").start()
		AREA2:
			if time_button_area2_pressed >= 1:
				get_node("..").startAGame("OptionB")
#				hide_option()
#				dialogue_count = 5
#				_on_NextButton_pressed()
		AREA3:
			get_tree().call_group("DoorHard","open_door")
		AREA4:
			#Start a game Level 4
			get_node("..").startAGame("OptionB")
			pass

#im calling this function on the semiboss script after he dies
func area1_after_semiboss_interation(option):
	match option:
		"optionA":
			dialogue_part = DIALOGUEAFINAL
		"optionB":
			dialogue_part = DIALOGUEBFINAL
	$Popup/DialogueBox/NextButton.visible = true
	dialogue_count = 0
	_on_NextButton_pressed()
	pop_up_show()

func area2_after_family_interation(option):
	match option:
		"optionA":
			dialogue_part = DIALOGUEAFINAL
		"optionB":
			dialogue_part = DIALOGUEBFINAL
	$Popup/DialogueBox/NextButton.visible = true
	dialogue_count = 0
	_on_NextButton_pressed()
	pop_up_show()

func area3_after_maze_interation(option):
	match option:
		"optionA":
			dialogue_part = DIALOGUEAFINAL
		"optionB":
			dialogue_part = DIALOGUEBFINAL
	$Popup/DialogueBox/NextButton.visible = true
	dialogue_count = 0
	_on_NextButton_pressed()
	pop_up_show()

func area4_after_protect_interation(option):
	match option:
		"optionA":
			dialogue_part = DIALOGUEAFINAL
		"optionB":
			dialogue_part = DIALOGUEBFINAL
	$Popup/DialogueBox/NextButton.visible = true
	dialogue_count = 0
	_on_NextButton_pressed()
	pop_up_show()

func _on_CloseButtonFinal_pressed():
	pop_up_hide()
	$Popup/DialogueBox/CloseButtonFinal.visible = false
	$Popup/DialogueBox/NextButton.visible = true
	if area_for_buttonB == "mind_area1":
		get_tree().change_scene(Global.level1)
		get_node("/root/PlayerInterface/Interface").visible = true
	if area_for_buttonB == "mind_area2":
		get_tree().change_scene(Global.level2)
		get_node("/root/PlayerInterface/Interface").visible = true
	if area_for_buttonB == "mind_area3":
		get_tree().change_scene(Global.level3)
		get_node("/root/PlayerInterface/Interface").visible = true
	if area_for_buttonB == "mind_area4":
		get_tree().change_scene(Global.level4)
		get_node("/root/PlayerInterface/Interface").visible = true
	queue_free()

func _on_DialogueTrigger_body_entered(body):
	if body == Global.Player:
		dialogue_count = 0
		dialogue_part = NORMALDIALOGUE
		_on_NextButton_pressed()
		pop_up_show()
