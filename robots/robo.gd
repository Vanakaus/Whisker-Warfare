extends Area2D

var moving = true
var mundo;
var gridSize = 64;

# Called when the node enters the scene tree for the first time.
func _ready():
	name = "Robot"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		global_position = global_position - Vector2(0.5, 0)




func atualizaPosicao(posicao):
	#posicao = (posicao * gridSize)
	#global_position = posicao
	global_position = Vector2(9, posicao) * 64



func _input(event):
	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE and event.is_pressed():
		var mouseClick = get_local_mouse_position()
		if mouseClick[0] > 0 and mouseClick[0] < 64:
			if mouseClick[1] > 0 and mouseClick[1] < 64:
				queue_free()


func _on_area_entered(area):
	if "Gato" in area.name:
		moving = false
