extends TileMap

var tileSelect;

@onready var gatoTest = preload("res://cats/test.tscn")
@onready var roboTest = preload("res://robots/testMal.tscn")

func _ready():	
	pass


func _process(delta):
	# Seleção do tile com o mouse
	if tileSelect != null and tileSelect[0] >= 0 and tileSelect[1] >= 0 and tileSelect[0] < 9  && tileSelect[1] < 5:
		erase_cell(1, tileSelect)

	tileSelect = local_to_map(get_global_mouse_position())
	
	if tileSelect[0] >= 0 and tileSelect[1] >= 0 and tileSelect[0] < 9  && tileSelect[1] < 5:
		set_cell(1, tileSelect, 1, Vector2i(0, 0), 0)
