extends Node2D

@onready var mundo = $/root/World
@onready var moneyLabel = get_node('FishQtd')


@onready var gatoPelo = preload("res://cats/bolaDePelo/gatoPelo.tscn")
@onready var gatoSonico = preload("res://cats/sonico/gatoSonico.tscn")
@onready var gatoPau = preload("res://cats/pau/gatoPau.tscn")
@onready var gatoDeGarras = preload("res://cats/garras/gatoGarras.tscn")
@onready var gatoDeBotas = preload("res://cats/botas/gatoBotas.tscn")
@onready var caixaDeAreia = preload("res://cats/caixa/caixaDeAreia.tscn")

@onready var gatoPeloButton = $GatoBolaDePeloButton
@onready var gatoPauButton = $GatoDePauButton
@onready var gatoSonicoButton = $GatoSonicButton
@onready var gatoDeGarrasButton = $GatoDeGarrasButton
@onready var gatoDeBotasButton = $GatoDeBotasButton
@onready var caixaDeAreiaButton = $CaixaDeAreiaButton

func _ready():
	pass # Replace with function body.



func _process(_delta):
	pass


func setMoney(money):
	moneyLabel.text = str(money)
	


func limparEscolhas(escolha):
	if escolha != 2:
		gatoPeloButton.deselaciona()
	if escolha != 3:
		gatoPauButton.deselaciona()
	if escolha != 4:
		gatoSonicoButton.deselaciona()
	if escolha != 5:
		gatoDeGarrasButton.deselaciona()
	if escolha != 6:
		gatoDeBotasButton.deselaciona()
	if escolha != 7:
		caixaDeAreiaButton.deselaciona()



func _on_gato_bola_de_pelo_button_pressed():
	limparEscolhas(2)
	mundo.selecionarGato(gatoPelo)


func _on_gato_de_pau_button_pressed():
	limparEscolhas(3)
	mundo.selecionarGato(gatoPau)


func _on_gato_sonic_button_pressed():
	limparEscolhas(4)
	mundo.selecionarGato(gatoSonico)


func _on_gato_de_garras_button_pressed():
	limparEscolhas(5)
	mundo.selecionarGato(gatoDeGarras)


func _on_gato_de_botas_button_pressed():
	limparEscolhas(6)
	mundo.selecionarGato(gatoDeBotas)


func _on_caixa_de_areia_button_pressed():
	limparEscolhas(7)
	mundo.selecionarGato(caixaDeAreia)
