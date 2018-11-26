extends CanvasLayer

enum states {YES, NO}
var isPressedKey = false

var state

func _ready():
	_change_state(YES)
	
	$NinePatchRect/Yes.connect("gui_input", self, "label_pressed");
	$NinePatchRect/No.connect("gui_input", self, "label_pressed");
	
	pass

func _process(delta):
	if (Input.is_key_pressed(KEY_RIGHT) && !isPressedKey):
		match state:
			YES:
				_change_state(NO)
		key_pressed()
		
	elif (Input.is_key_pressed(KEY_LEFT) && !isPressedKey):
		match state:
			NO:
				_change_state(YES)
		key_pressed()
		
	elif (Input.is_key_pressed(KEY_ENTER)):
		chooseOpition()
		
	pass

func _change_state(new_state):
	match new_state:
		YES:
			$NinePatchRect/HandCursor.rect_position = $NinePatchRect/PositionYes.rect_position
		NO:
			$NinePatchRect/HandCursor.rect_position = $NinePatchRect/PositionNo.rect_position
			
	state = new_state

func chooseOpition():
	match state:
			YES:
				get_tree().change_scene("res://Scenes/Level/Level.tscn")
				return
			NO:
				get_tree().change_scene("res://Main Menu/MainMenu.tscn")
				return

func key_pressed():
	isPressedKey = true
	$NinePatchRect/Timer.wait_time = 0.2
	$NinePatchRect/Timer.start()


func _on_Timer_timeout():
	isPressedKey = false
	
	pass # replace with function body
	
func label_pressed(input_event):
	if (input_event is InputEventMouseButton):
		chooseOpition()


func _on_No_mouse_entered():
	_change_state(NO)
	
	pass # replace with function body


func _on_Yes_mouse_entered():
	_change_state(YES)
	
	pass # replace with function body
