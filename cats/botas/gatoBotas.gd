extends Area2D

@onready var mundo = $/root/World

var enemies_at_area = 0
var ativa_ataque = 100
var verificador_ataque = ativa_ataque
var delay_ataque = 0.5
var porrete

var life
var price




func _ready():
	$Miado.play()



func criar():
	name = "Gato de Botas"
	set_meta("tipo", "Cat")
	life = 300
	price = 250



func colocar(posicao):	
	var gridIncrementVector = Vector2( 2 * LevelData.detectionIncrementX, LevelData.detectionIncrementY)

	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = gridIncrementVector
	get_node("DetectionArea/DetectionCollision").position = gridIncrementVector
	
	get_node("Porrada/CollisionShape2D").shape = get_node("Porrada/CollisionShape2D").shape.duplicate()
	get_node("Porrada/CollisionShape2D").shape.extents = gridIncrementVector
	get_node("Porrada/CollisionShape2D").position = gridIncrementVector
	
	porrete = get_node("Porrada")
	porrete.carregar()
	
	global_position = posicao * Vector2i(LevelData.tileSizeX, LevelData.tileSizeY)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if enemies_at_area:
		if verificador_ataque > delay_ataque:
			verificador_ataque = 0
			
			$AnimatedSprite2D.play("attack")
			if randf_range(0, 100) < 40:
				$Ataque.play()
			porrete.atacar(global_position)
			await get_tree().create_timer(0.2).timeout
			$AnimatedSprite2D.play("idle")
			porrete.carregar()
			

		else:
			verificador_ataque += delta;
			
	
	else:
		verificador_ataque = ativa_ataque



func _input(event):
	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE and event.is_pressed():
		var mouseClick = get_local_mouse_position()
		if mouseClick[0] > 0 and mouseClick[0] < LevelData.tileSizeX:
			if mouseClick[1] > 0 and mouseClick[1] < LevelData.tileSizeY:
				excluir()



func excluir():
	if global_position:
		mundo.limpaGridTile(global_position)
	queue_free()




func _on_detection_area_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Robot":
			enemies_at_area += 1



func _on_detection_area_area_exited(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Robot":
			enemies_at_area -= 1



func _on_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "soco":
			life -= area.dano
		
		if life <= 0:
			excluir()
