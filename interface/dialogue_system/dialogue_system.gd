extends CanvasLayer

var dialogue_count = 0
enum dialogue_part {NORMALDIALOGUE, DIALOGUEA, DIALOGUEAFINAL, DIALOGUEB, DIALOGUEBFINAL}
var dialogue
var buttons
enum WICHAREA {INITIALAREA, AREA1, AREA2, AREA3, AREA4, FINALAREA}
export(WICHAREA) var wich_area = WICHAREA.INITIALAREA
var area_for_buttonB

func _ready():
	dialogue = get_from_json(Global.dialogue_system)
	buttons = get_from_json(Global.buttons)
	Global.language_on = Global.ENGLISH
	if Global.language_on == Global.ENGLISH:
		$Popup/DialogueBox/NextButton/Label.text = buttons[0]["next"][0]
	elif Global.language_on == Global.PORTUGUESE:
		$Popup/DialogueBox/NextButton/Label.text = buttons[1]["next"][0]
	dialogue_part = NORMALDIALOGUE
	$Popup.show()
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
			AREA1:
				wich_area_button(0, "option1A", "option1B", "close1A", "close1B")
				wich_dialogue(0, "area1", "area1A", "area1AFinal", "area1B", "area1BFinal")
			AREA2:
				wich_area_button(0, "option2A", "option2B", "close2A", "close2B")
				wich_dialogue(0, "area2", "area2A", null, "area2B", null)
			AREA3:
				wich_dialogue(0, "area3", "area3A", "area3B")
			AREA4:
				wich_dialogue(0, "area4", "area4A", "area4B")
			FINALAREA:
				wich_area(0, "final_area")
	elif Global.language_on == Global.PORTUGUESE:
		match wich_area:
			INITIALAREA:
				wich_area(1, "initial_area")
			AREA1:
				wich_area_button(1, "option1A", "option1B", "close1A", "close1B")
				wich_dialogue(1, "area1", "area1A", "area1AFinal", "area1B", "area1BFinal")
			AREA2:
				wich_dialogue(1, "area2", "area2A", "area2B")
			AREA3:
				wich_dialogue(1, "area3", "area3A", "area3B")
			AREA4:
				wich_dialogue(1, "area4", "area4A", "area4B")
			FINALAREA:
				wich_area(1, "final_area")
	dialogue_count += 1

func wich_area(language, area):
	area_for_buttonB = area
	dialogue_count = clamp(dialogue_count, 0, dialogue[language][area].size() - 1)
	$Popup/DialogueBox/Label.text = dialogue[language][area][dialogue_count]

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
					if dialogue_count == dialogue[0][final_dialogue_a].size():
						$Popup.hide()
					wich_area(language, final_dialogue_a)
					
				elif dialogue_part == DIALOGUEB:
					if dialogue_count == dialogue[0][dialogue_b].size() - 1:
						$Popup/DialogueBox/CloseButtonB.visible = true
						$Popup/DialogueBox/NextButton.visible= false
					wich_area(language, dialogue_b)
					
				elif dialogue_part == DIALOGUEBFINAL:
					if wich_area == AREA1:
						if dialogue_count == dialogue[0][final_dialogue_b].size() - 1:
							Global.Player.unlock_stone_anim(Global.love_stone_texture)
					if dialogue_count == dialogue[0][final_dialogue_b].size():
						$Popup.hide()
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
		AREA2:
			pass
		AREA3:
			pass
		AREA4:
			pass
	hide_option()
	_on_NextButton_pressed()


func _on_OptionB_pressed():
	dialogue_part = DIALOGUEB
	match wich_area:
		AREA1:
			var cape = Global.freedom_cape.instance()
			Global.Player.add_child(cape)
		AREA2:
			pass
		AREA3:
			pass
		AREA4:
			pass
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

func _on_Area2D_body_entered(body):
#	$Tween.interpolate_property($Popup, "rect_position", Vector2(310, 780), Vector2(312, 380), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	$Tween.interpolate_property($Popup, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func _on_CloseButtonA_pressed():
	$Popup.hide()
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
			pass
		AREA3:
			pass
		AREA4:
			pass

func _on_CloseButtonB_pressed():
	$Popup.hide()
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
			pass
		AREA3:
			pass
		AREA4:
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
	$Popup.show()

func _on_CloseButtonFinal_pressed():
	$Popup.hide()
