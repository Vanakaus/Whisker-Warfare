extends Area2D

@onready var mundo = $/root/World


var estagio = 0;

var life



func _ready():
	#$Miado.play()
	pass



func criar():
	name = "Caixa de Areia"
	set_meta("tipo", "Cat")
	life = 400



func colocar(posicao):
	global_position = posicao * Vector2i(LevelData.tileSizeX, LevelData.tileSizeY)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



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
	


func _on_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "soco":
			life -= area.dano
		
		if life <= 300 and estagio != 1:
			estagio = 1
			$AnimatedSprite2D.play("estagio1")
		
		if life <= 200 and estagio != 2:
			estagio = 2
			$AnimatedSprite2D.play("estagio2")
		
		if life <= 100 and estagio != 1:
			estagio = 3
			$AnimatedSprite2D.play("estagio3")
		
		if life <= 0:
			excluir()
