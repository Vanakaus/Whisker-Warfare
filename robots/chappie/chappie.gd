extends Area2D


var mundo

var moving = true
var speed = 0.5
var atira = 100
var fire_counter = atira
var delay = 0.3


var life


func _ready():
	name = "Chappie"
	set_meta("tipo", "Robot")
	life = 100



func _process(delta):
	
	if moving:
		global_position -= Vector2(speed, 0)
		
		fire_counter = atira
		get_node("soco").position = Vector2(-1000, -1000)
		$AnimatedSprite2D.play("idle")
		
	else:
		if fire_counter > delay:
			fire_counter = 0
			
			$AnimatedSprite2D.play("attack")
			get_node("soco").position = Vector2(0, 0)
			await get_tree().create_timer(0.2).timeout
			$AnimatedSprite2D.play("idle")
			get_node("soco").position = Vector2(-1000, -1000)

		else:
			fire_counter += delta;



func atualizaPosicao(posicao, mundoPai):
	mundo = mundoPai
	
	var gridIncrementVector = Vector2(mundo.detectionIncrementX, mundo.detectionIncrementY)
	
	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = gridIncrementVector
	get_node("DetectionArea/DetectionCollision").position = gridIncrementVector
	
	get_node("Soco/CollisionShape2D").shape = get_node("Soco/CollisionShape2D").shape.duplicate()
	get_node("Soco/CollisionShape2D").shape.extents = gridIncrementVector
	get_node("Soco/CollisionShape2D").position = gridIncrementVector
	
	get_node("Soco").position = Vector2(0, 0)
	
	global_position = Vector2(9, posicao) * Vector2(mundo.tileSizeX, mundo.tileSizeY)






func _on_detection_area_area_entered(area):
		
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Cat":
			moving = false
		
		if area.get_meta("tipo") == "porrada" or area.get_meta("tipo") == "projetil":
			life -= area.dano
		
		if life <= 0:
			queue_free()



func _on_detection_area_area_exited(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Cat":
			moving = true
