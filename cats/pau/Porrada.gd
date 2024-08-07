extends Area2D

var dano


func _ready():
	name = 'porrada'
	set_meta("tipo", "porrada")
	dano = 15


func atacar(posicao):
	global_position = posicao


func carregar():
	global_position = Vector2(-1000, -1000)


func _process(delta):
	pass
