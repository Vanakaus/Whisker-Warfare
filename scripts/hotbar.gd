extends Node2D

@onready var mundo = $/root/Word
@onready var moneyLabel = get_node('FishQtd')


@onready var gatoPelo = preload("res://cats/bolaDePelo/gatoPelo.tscn")
@onready var gatoSonico = preload("res://cats/sonico/gatoSonico.tscn")
@onready var gatoPau = preload("res://cats/pau/gatoPau.tscn")

@onready var gatoPeloButton = $GatoBolaDePeloButton
@onready var gatoPauButton = $GatoDePauButton
@onready var gatoSonicoButton = $GatoSonicButton

func _ready():
	pass # Replace with function body.



func _process(delta):
	pass


func setMoney(money):
	moneyLabel.text = str(money)
	


func limparEscolhas(escolha):
	if escolha != 1:
		gatoPeloButton.deselaciona()
	if escolha != 2:
		gatoPauButton.deselaciona()
	if escolha != 3:
		gatoSonicoButton.deselaciona()



func _on_gato_bola_de_pelo_button_pressed():
	limparEscolhas(1)
	mundo.selecionarGato(gatoPelo)


func _on_gato_de_pau_button_pressed():
	limparEscolhas(2)
	mundo.selecionarGato(gatoPau)

func _on_gato_sonic_button_pressed():
	limparEscolhas(3)
	mundo.selecionarGato(gatoSonico)
