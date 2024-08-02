extends Node2D

@onready var mundo = $/root/Word


@onready var gatoPelo = preload("res://cats/bolaDePelo/gatoPelo.tscn")
@onready var gatoSonico = preload("res://cats/sonico/gatoSonico.tscn")
@onready var gatoPau = preload("res://cats/pau/gatoPau.tscn")



func _ready():
	pass # Replace with function body.



func _process(delta):
	pass


func _on_botao_gato_1_pressed():
	print("Apertou o botao do gato pelo")
	mundo.selecionarGato(gatoPelo)


func _on_botao_gato_2_pressed():
	print("Apertou o botao do gato sonico")	
	mundo.selecionarGato(gatoSonico)


func _on_botao_gato_3_pressed():
	print("Apertou o botao do gato pau")	
	mundo.selecionarGato(gatoPau)
