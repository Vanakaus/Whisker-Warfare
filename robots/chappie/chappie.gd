extends Area2D

var gridSizeX = 34
var gridSizeY = 24
var gridIncrementX = gridSizeX/2
var gridIncrementY = gridSizeY/2

var moving = true
var speed = 0.5
var atira = 100
var fire_counter = atira
var delay = 0.3
var life


# Called when the node enters the scene tree for the first time.
func _ready():
	name = "Robot"
	life = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if moving:
		global_position = global_position - Vector2(speed, 0)
		fire_counter = atira
		get_node("soco").position = Vector2(-1000, -1000)
		$AnimatedSprite2D.play("idle")
		
	else:
		
		if fire_counter > delay:
			fire_counter = 0
			$AnimatedSprite2D.play("attack")
			await get_tree().create_timer(0.2).timeout
			get_node("soco").position = Vector2(0, 0)

		else:
			fire_counter += delta;
			if fire_counter > 0.2:
				get_node("soco").position = Vector2(-1000, -1000)
				$AnimatedSprite2D.play("idle")
	



func atualizaPosicao(posicao):
	global_position = Vector2(9, posicao) * Vector2(gridSizeX, gridSizeY)
	
	var gridIncrementVector = Vector2(gridIncrementX, gridIncrementY)
	
	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = gridIncrementVector
	get_node("DetectionArea/DetectionCollision").position = gridIncrementVector
	
	get_node("Soco/CollisionShape2D").shape = get_node("Soco/CollisionShape2D").shape.duplicate()
	get_node("Soco/CollisionShape2D").shape.extents = gridIncrementVector
	get_node("Soco/CollisionShape2D").position = gridIncrementVector
	
	get_node("Soco").position = Vector2(0, 0)
	
	#posicao = posicao * Vector2i(gridSizeX, gridSizeY)
	#global_position = posicao






func _on_detection_area_area_entered(area):
	if "Cat" in area.name:
		moving = false
		
	if "porrada" in area.name:
		life -= area.dano
	
	if "projetil" in area.name:
		life -= area.dano
		
	if life <= 0:
		queue_free()



func _on_detection_area_area_exited(area):
	if "Cat" in area.name:
		moving = true
