extends Area2D
 

var moving = true
var speed = 0.25
var lentidao = 1
var lentidaoTimer = 1

var atira = 100
var fire_counter = atira
var delay = 1


var life


func _ready():
	name = "Chappie"
	set_meta("tipo", "Robot")
	life = 100



func _process(delta):
	
	if moving:
		global_position -= Vector2((speed * lentidao), 0)
		
		fire_counter = atira
		get_node("soco").position = Vector2(-1000, -1000)
		$AnimatedSprite2D.play("idle")
		
	elif not moving:
		if fire_counter > delay:
			fire_counter = 0
			
			$AnimatedSprite2D.play("idle")
			$Attack.play()
			$AnimatedSprite2D.play("attack")
			await get_tree().create_timer(0.75).timeout
			get_node("soco").position = Vector2(0, 0)
			await get_tree().create_timer(0.1).timeout
			get_node("soco").position = Vector2(-1000, -1000)

		else:
			fire_counter += delta;
	
	if lentidaoTimer > 0:
		lentidaoTimer -= delta
	else:
		lentidao = 1



func atualizaPosicao(posicao):
	
	var gridIncrementVector = Vector2(LevelData.detectionIncrementX, LevelData.detectionIncrementY)
	
	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = gridIncrementVector
	get_node("DetectionArea/DetectionCollision").position = gridIncrementVector
	
	get_node("Soco/CollisionShape2D").shape = get_node("Soco/CollisionShape2D").shape.duplicate()
	get_node("Soco/CollisionShape2D").shape.extents = gridIncrementVector
	get_node("Soco/CollisionShape2D").position = gridIncrementVector
	
	get_node("Soco").position = Vector2(0, 0)
	
	global_position = Vector2(11, posicao) * Vector2(LevelData.tileSizeX, LevelData.tileSizeY)






func _on_detection_area_area_entered(area):
	
	
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Cat":
			moving = false
		
		
		if area.get_meta("tipo") == "projetil":
			life -= area.dano
			area.excluir()
		
		
		if area.get_meta("tipo") == "porrada":
			life -= area.dano
	
	
	if area.has_meta("efeito"):
		if area.get_meta("efeito") == "lentidao":
			if area.lentidao < lentidao:
				lentidao = area.lentidao
				lentidaoTimer = 2
	
	
	if life <= 0:
		LevelData.numInimigos -=1
		queue_free()



func _on_detection_area_area_exited(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Cat":
			moving = true
