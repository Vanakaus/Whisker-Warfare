extends Node2D

var paused = false

var tileSizeX = 34
var tileSizeY = 24
var detectionIncrementX = tileSizeX/2
var detectionIncrementY = tileSizeY/2

var GridSizeX = 9
var GridSizeY = 5
var grid = {}

@onready var gatos = [$Lanes/Lane1/Gatos, $Lanes/Lane2/Gatos, $Lanes/Lane3/Gatos, $Lanes/Lane4/Gatos, $Lanes/Lane5/Gatos]
@onready var robos = [$Lanes/Lane1/Robos, $Lanes/Lane2/Robos, $Lanes/Lane3/Robos, $Lanes/Lane4/Robos, $Lanes/Lane5/Robos]
@onready var tileMap = $TileMap
@onready var hotbar = $Hotbar
@onready var pause_menu = $UI/PauseMenu
@onready var end_screen = $UI/EndScreen

@onready var inimigos = [
	preload("res://robots/chappie/chappie.tscn"),
	preload("res://robots/eurobo/eurobo.tscn"),
	preload("res://robots/aspirobo/aspirobo.tscn"),
	preload("res://robots/roborrifador/roborrifador.tscn"),
	preload("res://robots/tanquino/tanquino.tscn"),
	]



@onready var gato = null

@onready var level

@onready var money = 200

@onready var timerMoney = 0
@onready var timer = 0
@onready var index = 0

@onready var esperando = false
@onready var fimInimigos = false
@onready var fimFase = false





func _ready():	
	for x in GridSizeX:
		for y in GridSizeY:
			grid[str(Vector2(x, y))] = {
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
		if  robos[0].get_child_count() == 0:
			if robos[1].get_child_count() == 0:
				if robos[2].get_child_count() == 0:
					if robos[3].get_child_count() == 0:
						if robos[4].get_child_count() == 0:
							end_screen.gamewon()
							fimFase = true
		
		
	else:
		if timer >= level.data[index].tempo and not esperando:
			
			esperando = true
			
			for inimigo in level.data[index].inimigos:
				var robo = inimigos[inimigo].instantiate()
				var tile = RandomNumberGenerator.new().randi_range(0, 4)
				
				robo.atualizaPosicao(tile, self)
				robos[tile].call_deferred("add_child", robo)
				
				await get_tree().create_timer(0.25).timeout
			
			
			if level.data[index].fim:
				fimInimigos = true
			else:
				index = index + 1
			
			esperando = false



func selecionarGato(gatoEscolhido):
	gato = gatoEscolhido




func geraDinheiro(dinheiro):
	money += dinheiro
	hotbar.setMoney(money)




func _input(event):
	
	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var tileSelect = tileMap.local_to_map(get_global_mouse_position())
		
		print('\n')
		print('Tile: ', tileSelect)
		print('Tile.has: ', grid.has(str(tileSelect)))
		
		if grid.has(str(tileSelect)):
			
			print('Usado: ', grid[str(tileSelect)]["used"])
			
			if not grid[str(tileSelect)]["used"] and gato:
				
				var novoGato = gato.instantiate()
				novoGato.criar()
				
				if money >= novoGato.price:
					grid[str(tileSelect)]["used"] = true
					
					novoGato.colocar(tileSelect, self)
					gatos[tileSelect[1]].call_deferred("add_child", novoGato)
					
					money -= novoGato.price
					hotbar.setMoney(money)
				else:
					novoGato.excluir()
				
				hotbar.limparEscolhas(0)
				gato = null



	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		var tileSelect = tileMap.local_to_map(get_global_mouse_position())
		
		if grid.has(str(tileSelect)):
			var roboTeste = inimigos[1].instantiate()
			
			roboTeste.atualizaPosicao(tileSelect[1], self)
			robos[tileSelect[1]].call_deferred("add_child", roboTeste)



func limpaGridTile(mousePosition):
	var tileSelect = tileMap.local_to_map(mousePosition)
	
	if grid.has(str(tileSelect)):
		grid[str(tileSelect)]["used"] = false



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
