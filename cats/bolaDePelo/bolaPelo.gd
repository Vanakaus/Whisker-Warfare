extends Area2D

var dano


func _ready():
	name = 'bola de pelo'
	set_meta("tipo", "projetil")
	dano = 25


func atacar(posicao):
	global_position = posicao
	
	
func excluir():
	queue_free()


func _process(delta):
	global_position += Vector2(1, 0)



func _on_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Robot":
			queue_free()
