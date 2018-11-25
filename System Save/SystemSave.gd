extends Node

#Precisa do Path do arquivo do save
var SAVE_PATH = "res://System Save/save.json"

#variável com todas as informações
var save_dict

enum items {} #Pode colocar os itens como enum se quiser
enum levels {LOVE, FAMILY, SPIRIT, FRIENDSHIP}

func _ready():

	#Método que vai limpar o arquivo do save
	clear()
	
	pass
	
#cria padrão para salvar os objetos quando iniciar o jogo no menu iniciar
func clear():
	save_dict = {}
	save_dict.love = false
	save_dict.family = false
	save_dict.friendship = false
	save_dict.spirit = false
	save_dict.item1 = false
	save_dict.item2 = false
	save_dict.item3 = false
	save_dict.item4 = false
	save_dict.item5 = false
	save_dict.item6 = false
	save_dict.item7 = false
	save_dict.item8 = false
	
	#existindo ou não o arquivo, o programa vai salvar as informações
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_line(to_json(save_dict))
	file.close()
	pass

func get_item(index):
	match index:
		1:
			save_dict.item1 = true
		2:
			save_dict.item2 = true
		3:
			save_dict.item3 = true
		4:
			save_dict.item4 = true
		5:
			save_dict.item5 = true
		6:
			save_dict.item6 = true
		7:
			save_dict.item7 = true
		8:
			save_dict.item8 = true
			
	save_game()
	pass
	
func get_stone(level):
	match level:
		LOVE:
			save_dict.love = true
		FAMILY:
			save_dict.family = true
		SPIRIT:
			save_dict.spirit = true
		FRIENDSHIP:
			save_dict.friendship = true
			
	save_game()

#Usar após criar o padrão de arquivo (como a função clear())
func save_game():
	
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_line(to_json(save_dict))
	file.close()
	
	pass

#Usar durante o jogo para carregar a fase() ou depois que morrer e voltar para o inicio
func load_game():
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
		print("File Not Found")
		return
		
	file.open(SAVE_PATH,File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	
	print(data)
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Save_button_down():
	save_game()
	
	pass # replace with function body


func _on_Load_button_down():
	load_game()
	
	pass # replace with function body


#Daqui para baixo seriam as cenas onde o personagem consegue passar e tals
#Deopois que pegar o item ou passar da fase. Precisa chamar a classe GLOBAL acho
#e chamar sua respectiva função e salvar depois
func _on_Family_button_down():
	
	get_stone(FAMILY)
	
	pass # replace with function body


func _on_Spirit_button_down():
	get_stone(SPIRIT)
	
	pass # replace with function body


func _on_Friendship_button_down():
	get_stone(FRIENDSHIP)
	
	pass # replace with function body


func _on_Love_button_down():
	get_stone(LOVE)
	
	pass # replace with function body


func _on_Item1_button_down():
	get_item(1)
	
	pass # replace with function body


func _on_Item4_button_down():
	get_item(4)
	
	pass # replace with function body
