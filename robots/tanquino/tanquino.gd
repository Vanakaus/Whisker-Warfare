extends Area2D


@onready var mundo = $/root/World
@onready var pepinoCena = preload("res://robots/tanquino/tanquinoAtaque.tscn")


var moving = true
var speed = 0.16
var lentidao = 1
var lentidaoTimer = 1

var atira = 100
var fire_counter = atira
var delay = 4


var life


func _ready():
	name = "Tanquino"
	set_meta("tipo", "Robot")
	life = 400



func _process(delta):
	
	if moving:
		global_position -= Vector2((speed * lentidao), 0)
		
		fire_counter = atira
		$AnimatedSprite2D.play("idle")
		
	elif not moving:
		if fire_counter > delay:
			fire_counter = 0
			
			var pepino = pepinoCena.instantiate()
			
			pepino.atacar(global_position)
			mundo.get_node('Projeteis').add_child(pepino)
			
			
			$AnimatedSprite2D.play("attack")


		else:
			fire_counter += delta;
	
	if lentidaoTimer > 0:
		lentidaoTimer -= delta
	else:
		lentidao = 1



func atualizaPosicao(posicao):
	
	var gridIncrementVector = Vector2(LevelData.detectionIncrementX*2.8, LevelData.detectionIncrementY)
	
	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = gridIncrementVector
	get_node("DetectionArea/DetectionCollision").position = Vector2(-gridIncrementVector[0]+LevelData.detectionIncrementX*2, gridIncrementVector[1])
	
	global_position = Vector2(LevelData.spawnRobots, posicao) * Vector2(LevelData.tileSizeX, LevelData.tileSizeY)






func _on_detection_area_area_entered(area):
	
	
	if area.get_meta("tipo") == "Cat":
		moving = false



func _on_detection_area_area_exited(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Cat":
			moving = true




func _on_area_entered(area):
	
	if area.get_meta("tipo") == "projetil":
		life -= area.dano
		area.excluir()
	
	
	if area.get_meta("tipo") == "porrada":
		life -= area.dano
	
	
	if area.get_meta("efeito") == "lentidao":
		if area.lentidao < lentidao:
			lentidao = area.lentidao
			lentidaoTimer = 2
	
	
	if life <= 0:
		LevelData.numInimigos -=1
		queue_free()
