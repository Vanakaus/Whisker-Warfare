extends Node2D

var game_over = false
var GridSizeX = 9;
var GridSizeY = 5;
var grid = {};

@onready var gatoTest = preload("res://cats/test.tscn")
@onready var roboTest = preload("res://robots/testMal.tscn")
@onready var tileMap = $TileMap



# Called when the node enters the scene tree for the first time.
func _ready():
	for x in GridSizeX:
		for y in GridSizeY:
			grid[str(Vector2(x, y))] = {
				"used" : false
			}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _input(event):
	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var tileSelect = tileMap.local_to_map(get_global_mouse_position())
		
		if grid.has(str(tileSelect)):
			if not grid[str(tileSelect)]["used"]:
				grid[str(tileSelect)]["used"] = true
				var gatoTeste = gatoTest.instantiate()
				add_child(gatoTeste)
				gatoTeste.atualizaPosicao(tileSelect, self)




	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		var tileSelect = tileMap.local_to_map(get_global_mouse_position())
		
		if grid.has(str(tileSelect)):
			var roboTeste = roboTest.instantiate()
			add_child(roboTeste)
			roboTeste.atualizaPosicao(tileSelect[1])




func limpaGridTile(mousePosition):
	var tileSelect = tileMap.local_to_map(mousePosition)
	if grid.has(str(tileSelect)):
		grid[str(tileSelect)]["used"] = false


func _on_game_over_area_entered(area):
	if "Robot" in area.name:
		game_over = true
		print("Perdemo")
