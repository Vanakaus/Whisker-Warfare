extends Area2D

@onready var mundo = $/root/Word


var enemies_at_area = 0
var ativa_ataque = 100
var verificador_ataque = ativa_ataque
var delay_ataque = 1.5

var life
var cost
@onready var ondas = preload("res://cats/sonico/ondas.tscn")




func _ready():
	name = "Gato Sonico"
	set_meta("tipo", "Cat")
	life = 100
	cost = 125



func _process(delta):
	
	if enemies_at_area:
		
		if verificador_ataque > delay_ataque:
			var onda = ondas.instantiate()
			onda.atacar(global_position)
			mundo.get_node('Projeteis').add_child(onda)
			verificador_ataque = 0
			$AnimatedSprite2D.play("attack")

		else:
			verificador_ataque += delta;
			if verificador_ataque > 0.2:
				$AnimatedSprite2D.play("idle")
	
	else:
		verificador_ataque = ativa_ataque
		$AnimatedSprite2D.play("idle")



func colocar(posicao, mundo):
	
	var gridIncrementVector = Vector2( (9 - posicao[0]) * mundo.detectionIncrementX, mundo.detectionIncrementY)
	
	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = gridIncrementVector
	get_node("DetectionArea/DetectionCollision").position = gridIncrementVector
	
	global_position = posicao * Vector2i(mundo.tileSizeX, mundo.tileSizeY)





func _input(event):
	# Verificar se o evento é um clique de mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE and event.is_pressed():
		var mouseClick = get_local_mouse_position()
		if mouseClick[0] > 0 and mouseClick[0] < mundo.tileSizeX:
			if mouseClick[1] > 0 and mouseClick[1] < mundo.tileSizeY:
				excluir()



func excluir():
	mundo.limpaGridTile(get_global_mouse_position())
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
