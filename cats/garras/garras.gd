extends Area2D

var dano


func _ready():
	name = 'garras'
	set_meta("tipo", "porrada")
	dano = 25
	await get_tree().create_timer(1).timeout
	get_node("Collision").position = Vector2(-1000, 0)
	#await get_tree().create_timer(1).timeout
	queue_free()
	


func atacar(posicao):
	global_position = posicao


func _process(_delta):
	pass
