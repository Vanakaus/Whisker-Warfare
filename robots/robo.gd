extends Area2D

var moving = true
var mundo;
var gridSizeX = 34
var gridSizeY = 24
var speed = 0.5
var life




# Called when the node enters the scene tree for the first time.
func _ready():
	name = "Robot"
	life = 100



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		global_position = global_position - Vector2(speed, 0)




func atualizaPosicao(posicao):
	global_position = Vector2(9, posicao) * Vector2(gridSizeX, gridSizeY)




func _input(event):
	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE and event.is_pressed():
		var mouseClick = get_local_mouse_position()
		if mouseClick[0] > 0 and mouseClick[0] < gridSizeX:
			if mouseClick[1] > 0 and mouseClick[1] < gridSizeY:
				queue_free()




func _on_area_entered(area):
	if "Gato" in area.name:
		moving = false
		
	if "porrada" in area.name:
		print(life)
		life -= area.dano
	
	if "projetil" in area.name:
		life -= area.dano
		
	if life <= 0:
		queue_free()



func _on_area_exited(area):
	if "Gato" in area.name:
		moving = true
