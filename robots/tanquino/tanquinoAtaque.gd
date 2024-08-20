extends Area2D

var dano
var speed = 0.35


func _ready():
	name = 'Pepino'
	set_meta("tipo", "soco")
	dano = 100


func atacar(posicao):
	global_position = Vector2(posicao[0] - 24, posicao[1])
	
	
func excluir():
	queue_free()


func _process(_delta):
	global_position -= Vector2(speed, 0)


func _on_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Cat":
			queue_free()
