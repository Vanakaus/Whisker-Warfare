extends Area2D

var dano

# Called when the node enters the scene tree for the first time.
func _ready():
	name = 'projetil'
	dano = 25


func cospe(posicao):
	global_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += Vector2(1, 0)


func _on_area_entered(area):
	if 'Robot' in area.name:
		queue_free()
