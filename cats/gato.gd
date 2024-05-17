extends Area2D

var mundo
var gridSize = 64
var enemies_at_area = 0
var shooting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	name = "Gato"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemies_at_area:
		shooting = true
	else:
		shooting = false


func atualizaPosicao(posicao, mundoPai):
	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = Vector2((9 - posicao[0]) * 32, 32)
	get_node("DetectionArea/DetectionCollision").position = Vector2((9 - posicao[0]) * 32, 32)
	
	mundo = mundoPai
	posicao = (posicao * gridSize)
	global_position = posicao

func _input(event):
	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE and event.is_pressed():
		var mouseClick = get_local_mouse_position()
		if mouseClick[0] > 0 and mouseClick[0] < 64:
			if mouseClick[1] > 0 and mouseClick[1] < 64:
				mundo.limpaGridTile(get_global_mouse_position())
				queue_free()


func _on_detection_area_area_entered(area):
	if "Robot" in area.name:
		print("Entrou")
		enemies_at_area += 1


func _on_detection_area_area_exited(area):
	if "Robot" in area.name:
		print("Saiu")
		enemies_at_area -= 1
