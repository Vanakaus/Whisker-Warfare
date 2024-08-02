extends TileMap

var tileSelect;
var tileType = 1;
var tileVariation1 = 0;
var tileVariation2 = 1;


@onready var word = $/root/Word




func _ready():
	
#	Gerando o TileMap
	for x in range(-1, word.GridSizeX):
		for y in range(-1, word.GridSizeY):
			
#			Alternando entre as variações do TileMap
			if (x + y) % 2:
				set_cell(0, Vector2(x, y), 0, Vector2(tileVariation1, tileType), 0)
			else:
				set_cell(0, Vector2(x, y), 0, Vector2(tileVariation2, tileType), 0)



func _process(delta):
	# Seleção do tile com o mouse
	if tileSelect != null and tileSelect[0] >= 0 and tileSelect[1] >= 0 and tileSelect[0] < 9  && tileSelect[1] < 5:
		erase_cell(1, tileSelect)

	tileSelect = local_to_map(get_global_mouse_position())
	
	if tileSelect[0] >= 0 and tileSelect[1] >= 0 and tileSelect[0] < 9  && tileSelect[1] < 5:
		set_cell(1, tileSelect, 0, Vector2i(0, 0), 0)
