extends Area2D


@onready var mundo = $/root/World
@onready var laserCena = preload("res://robots/zurgoid/zurgoidAtaque.tscn")
var gatosPos := []

var moving = true
var speed = 0.15
var lentidao = 1
var lentidaoTimer = 1

var atira = 100
var fire_counter = atira
var delay = 6


var life


func _ready():
	name = "Zurgoid"
	set_meta("tipo", "Robot")
	life = 1000



func _process(delta):
	
	if moving:
		global_position -= Vector2((speed * lentidao), 0)
		
		fire_counter = atira
		$AnimatedSprite2D.play("idle")
		
	elif not moving:
		if fire_counter > delay:
			fire_counter = 0
			
			var laser = laserCena.instantiate()
			
			laser.atacar(global_position - Vector2(-16, 16), gatosPos[0])
			mundo.get_node('Projeteis').add_child(laser)
			
			
			$AnimatedSprite2D.play("attack")


		else:
			fire_counter += delta;
	
	if lentidaoTimer > 0:
		lentidaoTimer -= delta
	else:
		lentidao = 1



func atualizaPosicao(posicao):
	
	var gridIncrementVector = Vector2(LevelData.detectionIncrementX*4, LevelData.detectionIncrementY*5)
	
	get_node("DetectionArea/DetectionCollision").shape = get_node("DetectionArea/DetectionCollision").shape.duplicate()
	get_node("DetectionArea/DetectionCollision").shape.extents = gridIncrementVector 
	get_node("DetectionArea/DetectionCollision").position = Vector2(-gridIncrementVector[0]+LevelData.detectionIncrementX*2, (0.5 * LevelData.tileSizeY))
	
	global_position = Vector2(11, posicao) * Vector2(LevelData.tileSizeX, LevelData.tileSizeY)






func _on_detection_area_area_entered(area):
	
	if area.get_meta("tipo") == "Cat":
		moving = false
		gatosPos.push_back(area.position)



func _on_detection_area_area_exited(area):
	if area.has_meta("tipo"):
		if area.get_meta("tipo") == "Cat":
			
			if gatosPos.has(area.position):
				gatosPos.remove_at(gatosPos.find(area.position))
			
			if gatosPos.size() == 0:
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
