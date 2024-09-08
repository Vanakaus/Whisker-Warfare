extends Node2D

var paused = false

@onready var gatos = [$Lanes/Lane1/Gatos, $Lanes/Lane2/Gatos, $Lanes/Lane3/Gatos, $Lanes/Lane4/Gatos, $Lanes/Lane5/Gatos]
@onready var robos = [$Lanes/Lane1/Robos, $Lanes/Lane2/Robos, $Lanes/Lane3/Robos, $Lanes/Lane4/Robos, $Lanes/Lane5/Robos]
@onready var tileMap = $TileMap
@onready var hotbar = $Hotbar
@onready var pause_menu = $UI/PauseMenu
@onready var end_screen = $UI/EndScreen




@onready var gato = null

@onready var level

@onready var money = LevelData.dinheiroInicial

@onready var timerMoney = 0
@onready var timer = 0
@onready var index = 0

@onready var esperando = false
@onready var fimInimigos = false
@onready var fimFase = false





func _ready():	
	for x in LevelData.GridSizeX:
		for y in LevelData.GridSizeY:
			LevelData.grid[str(Vector2(x, y))] = {
				"used" : false
			}
	
	hotbar.setMoney(money)
	
#	Carregando o script do level 1
	var file = FileAccess.open("res://scripts/leveis/level_" + str(LevelData.level) + ".json", FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	level = JSON.new()
	var error = level.parse(content)
	if not error == OK:
		print("JSON Parse Error: ", level.get_error_message(), " in ", content, " at line ", level.get_error_line())

	pause_menu.visible = false
	end_screen.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timerMoney += delta
	timer += delta
	
	if fimFase:
		return
	
	if timerMoney >= 30:
		money += 50;
		hotbar.setMoney(money)
		timerMoney = 0
	
	if fimInimigos:
		if LevelData.numInimigos == 0:
			end_screen.gamewon()
			fimFase = true
		
	else:
		if timer >= level.data[index].tempo and not esperando:
			
			esperando = true
			
			for inimigo in level.data[index].inimigos:
				var robo = LevelData.robosCenas[inimigo].instantiate()
				var tile = RandomNumberGenerator.new().randi_range(0, 4)
				
				LevelData.numInimigos += 1
				
				robo.atualizaPosicao(tile)
				robos[tile].call_deferred("add_child", robo)
				
				await get_tree().create_timer(0.25).timeout
			
			
			if level.data[index].fim:
				fimInimigos = true
			else:
				index = index + 1
			
			esperando = false



func selecionarGato(gatoEscolhido):
	print(gatoEscolhido)
	#gato = gatoEscolhido
	if gatoEscolhido != 0:
		gato = LevelData.gatos[gatoEscolhido-1]
	else:
		gato = null
	




func geraDinheiro(dinheiro):
	money += dinheiro
	hotbar.setMoney(money)




func _input(event):
	
	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var tileSelect = tileMap.local_to_map(get_global_mouse_position())
		
		print('\n')
		print('Tile: ', tileSelect)
		print('Tile.has: ', LevelData.grid.has(str(tileSelect)))
		
		if LevelData.grid.has(str(tileSelect)):
			
			print('Usado: ', LevelData.grid[str(tileSelect)]["used"])
			
			if not LevelData.grid[str(tileSelect)]["used"] and gato:
				
				
				if money >= gato.preco:
					LevelData.grid[str(tileSelect)]["used"] = true
					
					var novoGato = gato.cena.instantiate()
					novoGato.criar()
					
					novoGato.colocar(tileSelect)
					gatos[tileSelect[1]].call_deferred("add_child", novoGato)
					
					money -= gato.preco
					hotbar.setMoney(money)
				
				hotbar.escolher(0)
				gato = null



	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		var tileSelect = tileMap.local_to_map(get_global_mouse_position())
		
		if LevelData.grid.has(str(tileSelect)):
			var roboTeste = LevelData.robosCenas[5].instantiate()
			
			roboTeste.atualizaPosicao(tileSelect[1])
			robos[tileSelect[1]].call_deferred("add_child", roboTeste)



func limpaGridTile(mousePosition):
	var tileSelect = tileMap.local_to_map(mousePosition)
	
	if LevelData.grid.has(str(tileSelect)):
		LevelData.grid[str(tileSelect)]["used"] = false



func _on_game_over_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Robot":
			print("entrou na area do gameover")
			end_screen.gameover()
		


func _on_play_again_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_back_to_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://elements/main_menu.tscn")
