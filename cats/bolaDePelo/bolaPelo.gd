extends Area2D

var dano
var speed = 0.6


func _ready():
	name = 'bola de pelo'
	set_meta("tipo", "projetil")
	dano = 25


func atacar(posicao):
	global_position = posicao
	
	
func excluir():
	queue_free()


func _process(_delta):
	global_position += Vector2(speed, 0)



func _on_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Robot":
			queue_free()
