extends Node

enum states {START, CREDITS, EXIT}
enum languages { BR, US}

var state
var language
var isPressedKey = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	_change_state(START)
	_change_language(US)
	$NinePatchRect/VBoxContainer/Start.connect("gui_input", self, "label_pressed");
	$NinePatchRect/VBoxContainer/Credits.connect("gui_input", self, "label_pressed");
	$NinePatchRect/VBoxContainer/Exit.connect("gui_input", self, "label_pressed");
	var projectResolution = ProjectSettings.get_setting("display/window/size/width")
	print(projectResolution)

func _process(delta):
	
	if (Input.is_key_pressed(KEY_UP) && !isPressedKey):
		match state:
			CREDITS:
				_change_state(START)
			EXIT:
				_change_state(CREDITS)
		key_pressed()
		
	elif (Input.is_key_pressed(KEY_DOWN) && !isPressedKey):
		match state:
			START:
				_change_state(CREDITS)
			CREDITS:
				_change_state(EXIT)
		key_pressed()
		
	elif (Input.is_key_pressed(KEY_ENTER)):
		chooseOpition()

func _change_language(new_lang):
	match new_lang:
			BR:
				print("eita xiovana")
				Global.language_on = Global.languages.PORTUGUESE
				$NinePatchRect/HBoxContainer/buttonBR.modulate = Color(1, 1, 1)
				$NinePatchRect/HBoxContainer/buttonUS.modulate = Color(0.3, 0.3, 0.3)
				return
			US:
				Global.language_on = Global.languages.ENGLISH
				$NinePatchRect/HBoxContainer/buttonBR.modulate = Color(0.3, 0.3, 0.3)
				$NinePatchRect/HBoxContainer/buttonUS.modulate = Color(1, 1, 1)
				return
				
	language = new_lang

func chooseOpition():
	match state:
			START:
				get_tree().change_scene("res://Scenes/Level/Level.tscn")
				return
			CREDITS:
				return
			EXIT:
				get_tree().quit()

func key_pressed():
	isPressedKey = true
	$NinePatchRect/Timer.wait_time = 0.2
	$NinePatchRect/Timer.start()

func _change_state(new_state):
	match new_state:
		START:
			$NinePatchRect/HandCursor.rect_position = $NinePatchRect/PositionStart.rect_position
		CREDITS:
			$NinePatchRect/HandCursor.rect_position = $NinePatchRect/PositionCredits.rect_position
		EXIT:
			$NinePatchRect/HandCursor.rect_position = $NinePatchRect/PositionExit.rect_position
			
	state = new_state

func _on_Start_mouse_entered():
	_change_state(START)


func _on_Credits_mouse_entered():
	_change_state(CREDITS)


func _on_Exit_mouse_entered():
	_change_state(EXIT)


func label_pressed(input_event):
	if (input_event is InputEventMouseButton):
		chooseOpition()

func _on_Timer_timeout():
	isPressedKey = false


func _on_buttonBR_pressed():
	_change_language(BR)

func _on_buttonUS_pressed():
	_change_language(US)

