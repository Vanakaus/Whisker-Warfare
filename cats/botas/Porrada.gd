extends Area2D

var dano


func _ready():
	name = 'espadada'
	set_meta("tipo", "porrada")
	dano = 25


func atacar(posicao):
	global_position = posicao


func carregar():
	global_position = Vector2(-1000, -1000)


func _process(_delta):
	pass
