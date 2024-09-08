extends Area2D

var dano
var speed = 0.6
var direcaoVetor
var direcaoRotacao


func _ready():
	name = 'Laser'
	set_meta("tipo", "soco")
	dano = 300


func atacar(posicao, alvo):
	global_position = Vector2(posicao[0] - 24, posicao[1])
	direcaoVetor = posicao - alvo
	direcaoRotacao = direcaoVetor.angle()
	$Sprite2D.rotate(direcaoRotacao)

	
	
func excluir():
	queue_free()


func _process(_delta):
	global_position -= speed * direcaoVetor.normalized()


func _on_area_entered(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Cat":
			queue_free()
