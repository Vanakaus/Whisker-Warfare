extends Area2D

var dano
var lentidao


func _ready():
	name = 'projetil'
	set_meta("tipo", "projetil")
	set_meta("efeito", "lentidao")
	dano = 17
	lentidao = 0.6


func atacar(posicao):
	global_position = posicao
	
	
func excluir():
	queue_free()


func _process(delta):
	global_position += Vector2(0.6, 0)



func _on_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Robot":
			queue_free()
