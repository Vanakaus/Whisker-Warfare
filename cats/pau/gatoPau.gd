extends Area2D

var mundo
var gridSizeX = 34
var gridSizeY = 24
var gridIncrementX = gridSizeX/2
var gridIncrementY = gridSizeY/2
var enemies_at_area = 0
var atira = 100
var fire_counter = atira
var delay = 0.3


# Called when the node enters the scene tree for the first time.
func _ready():
	name = "Cat"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if enemies_at_area:
		
		if fire_counter > delay:
			fire_counter = 0
			$AnimatedSprite2D.play("attack")
			await get_tree().create_timer(0.2).timeout
			get_node("porrada").position = Vector2(0, 0)

		else:
			fire_counter += delta;
			if fire_counter > 0.2:
				get_node("porrada").position = Vector2(-1000, -1000)
				$AnimatedSprite2D.play("idle")
	
	else:
		fire_counter = atira
		get_node("porrada").position = Vector2(-1000, -1000)
		$AnimatedSprite2D.play("idle")



func atualizaPosicao(posicao, mundoPai):
	var gridIncrementVector = Vector2(1.2 * gridIncrementX, gridIncrementY)
	
	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = gridIncrementVector
	get_node("DetectionArea/DetectionCollision").position = gridIncrementVector
	
	get_node("Porrada/CollisionShape2D").shape = get_node("Porrada/CollisionShape2D").shape.duplicate()
	get_node("Porrada/CollisionShape2D").shape.extents = gridIncrementVector
	get_node("Porrada/CollisionShape2D").position = gridIncrementVector
	
	get_node("Porrada").position = Vector2(-1000, -1000)
	
	mundo = mundoPai
	posicao = posicao * Vector2i(gridSizeX, gridSizeY)
	global_position = posicao




func _input(event):
	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE and event.is_pressed():
		var mouseClick = get_local_mouse_position()
		if mouseClick[0] > 0 and mouseClick[0] < 34:
			if mouseClick[1] > 0 and mouseClick[1] < 24:
				mundo.limpaGridTile(get_global_mouse_position())
				queue_free()




func _on_detection_area_area_entered(area):
	if "Robot" in area.name:
		enemies_at_area += 1



func _on_detection_area_area_exited(area):
	if "Robot" in area.name:
		enemies_at_area -= 1
