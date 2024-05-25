extends Area2D
#16x11
var dano

# Called when the node enters the scene tree for the first time.
func _ready():
	name = 'projetil'
	dano = 17


func cospe(posicao):
	global_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += Vector2(0.6, 0)


func _on_area_entered(area):
	if 'Robot' in area.name:
		queue_free()
