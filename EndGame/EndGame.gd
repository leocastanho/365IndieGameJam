extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var anim = $AnimationPlayer

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_node("/root/PlayerInterface/Interface").visible = false
	anim.play("Text1")
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "Text1"):
		anim.play("Text2")
	elif(anim_name == "Text2"):
		anim.play("Text3")
	elif(anim_name == "Text3"):
		anim.play("FinalText")
	elif(anim_name == "FinalText"):
		anim.play("End")
	elif(anim_name == "End"):
		get_tree().change_scene("res://Main Menu/MainMenu.tscn")
	
	
	pass # replace with function body
