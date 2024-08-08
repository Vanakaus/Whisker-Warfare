extends Node2D

var game_over = false
var timer = 0

var tileSizeX = 34
var tileSizeY = 24
var detectionIncrementX = tileSizeX/2
var detectionIncrementY = tileSizeY/2

var GridSizeX = 9;
var GridSizeY = 5;
var grid = {};


@onready var lanes = [$Lanes/Lane1, $Lanes/Lane2, $Lanes/Lane3, $Lanes/Lane4, $Lanes/Lane5]
@onready var tileMap = $TileMap
@onready var hotbar = $Hotbar


@onready var gatoPelo = preload("res://cats/bolaDePelo/gatoPelo.tscn")
@onready var gatoPau = preload("res://cats/pau/gatoPau.tscn")
@onready var gatoSonico = preload("res://cats/sonico/gatoSonico.tscn")


@onready var chappie = preload("res://robots/chappie/chappie.tscn")



@onready var gato = null

@onready var money = 1000




# Called when the node enters the scene tree for the first time.
func _ready():
	for x in GridSizeX:
		for y in GridSizeY:
			grid[str(Vector2(x, y))] = {
				"used" : false
			}
	
	hotbar.setMoney(money)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	
	if timer >= 5:
		var roboTeste = chappie.instantiate()
		var rng = RandomNumberGenerator.new()
		var tile = rng.randi_range(0, 4)
		
		roboTeste.atualizaPosicao(tile, self)
		lanes[tile].call_deferred("add_child", roboTeste)
		
		timer = 0
		



func selecionarGato(gatoEscolhido):
	gato = gatoEscolhido




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
				novoGato.criar(tileSelect)
				
				if money >= novoGato.price:
					grid[str(tileSelect)]["used"] = true
					
					novoGato.colocar(tileSelect, self)
					lanes[tileSelect[1]].call_deferred("add_child", novoGato)
					
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
			var roboTeste = chappie.instantiate()
			
			roboTeste.atualizaPosicao(tileSelect[1], self)
			lanes[tileSelect[1]].call_deferred("add_child", roboTeste)



func limpaGridTile(mousePosition):
	var tileSelect = tileMap.local_to_map(mousePosition)
	
	if grid.has(str(tileSelect)):
		grid[str(tileSelect)]["used"] = false



func _on_game_over_area_entered(area):
	if "Robot" in area.name:
		game_over = true
		print("Perdemo")
