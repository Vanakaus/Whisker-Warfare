extends Area2D

@onready var mundo = $/root/Word

var enemies_at_area = 0
var ativa_ataque = 100
var verificador_ataque = ativa_ataque
var delay_ataque = 0.3
var porrete

var life
var price




func _ready():
	pass



func criar(posicao):
	name = "Gato da Dn Chica"
	set_meta("tipo", "Cat")
	life = 500
	price = 75



func colocar(posicao, mundo):	
	var gridIncrementVector = Vector2( 1.2 * mundo.detectionIncrementX, mundo.detectionIncrementY)

	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = gridIncrementVector
	get_node("DetectionArea/DetectionCollision").position = gridIncrementVector
	
	get_node("Porrada/CollisionShape2D").shape = get_node("Porrada/CollisionShape2D").shape.duplicate()
	get_node("Porrada/CollisionShape2D").shape.extents = gridIncrementVector
	get_node("Porrada/CollisionShape2D").position = gridIncrementVector
	
	porrete = get_node("Porrada")
	porrete.carregar()
	
	global_position = posicao * Vector2i(mundo.tileSizeX, mundo.tileSizeY)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if enemies_at_area:
		if verificador_ataque > delay_ataque:
			verificador_ataque = 0
			
			$AnimatedSprite2D.play("attack")
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
		if mouseClick[0] > 0 and mouseClick[0] < mundo.tileSizeX:
			if mouseClick[1] > 0 and mouseClick[1] < mundo.tileSizeY:
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
