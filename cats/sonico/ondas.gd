extends Area2D

var dano


func _ready():
	name = 'projetil'
	set_meta("tipo", "projetil")
	dano = 17


func cospe(posicao):
	global_position = position


func _process(delta):
	global_position += Vector2(0.6, 0)



func _on_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Robot":
			queue_free()
