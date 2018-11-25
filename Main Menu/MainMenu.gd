extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

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
	$Start.connect("gui_input", self, "label_pressed");
	$Credits.connect("gui_input", self, "label_pressed");
	$Exit.connect("gui_input", self, "label_pressed");
	pass

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
				
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func _change_language(new_lang):
	match new_lang:
			BR:
				Global.language_on = Global.languages.PORTUGUESE
				$LanguageButton/buttonBR.modulate = Color(1, 1, 1)
				$LanguageButton/buttonUS.modulate = Color(0.3, 0.3, 0.3)
				return
			US:
				Global.language_on = Global.languages.ENGLISH
				$LanguageButton/buttonUS.modulate = Color(1, 1, 1)
				$LanguageButton/buttonBR.modulate = Color(0.3, 0.3, 0.3)
				return
				
	language = new_lang

func chooseOpition():
	match state:
			START:
				get_tree().change_scene("res://Scenes/Level/Level4.tscn")
				return
			CREDITS:
				return
			EXIT:
				get_tree().quit()

func key_pressed():
	isPressedKey = true
	$Timer.wait_time = 0.2
	$Timer.start()

func _change_state(new_state):
	match new_state:
		START:
			$HandCursor.position = $Start/PositionStart.global_position
		CREDITS:
			$HandCursor.position = $Credits/PositionCredits.global_position
		EXIT:
			$HandCursor.position = $Exit/PositionExit.global_position
			
	state = new_state
	
func _on_Start_mouse_entered():
	
	_change_state(START)
	
	pass # replace with function body


func _on_Credits_mouse_entered():
	
	_change_state(CREDITS)
	
	pass # replace with function body


func _on_Exit_mouse_entered():
	
	_change_state(EXIT)
	
	pass # replace with function body


func label_pressed(input_event):
	if (input_event is InputEventMouseButton):
		chooseOpition()
	
	pass

func _on_Timer_timeout():
	
	isPressedKey = false
	
	pass # replace with function body


func _on_buttonBR_button_down():
	_change_language(BR)
	
	pass # replace with function body


func _on_buttonUS_button_down():
	_change_language(US)
	
	pass # replace with function body
