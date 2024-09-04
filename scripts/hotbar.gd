extends Node2D

@onready var mundo = $/root/World
@onready var moneyLabel = get_node('FishQtd')


@onready var aquario = preload("res://cats/aquario/aquario.tscn")
@onready var gatoPelo = preload("res://cats/bolaDePelo/gatoPelo.tscn")
@onready var gatoSonico = preload("res://cats/sonico/gatoSonico.tscn")
@onready var gatoPau = preload("res://cats/pau/gatoPau.tscn")
@onready var gatoDeGarras = preload("res://cats/garras/gatoGarras.tscn")
@onready var gatoDeBotas = preload("res://cats/botas/gatoBotas.tscn")
@onready var caixaDeAreia = preload("res://cats/caixa/caixaDeAreia.tscn")

@onready var aquarioButton = $AquarioButton
@onready var gatoPeloButton = $GatoBolaDePeloButton
@onready var gatoPauButton = $GatoDePauButton
@onready var gatoSonicoButton = $GatoSonicButton
@onready var gatoDeGarrasButton = $GatoDeGarrasButton
@onready var gatoDeBotasButton = $GatoDeBotasButton
@onready var caixaDeAreiaButton = $CaixaDeAreiaButton


@onready var plantas



func _ready():
	#Carregando o script do level 1
	var file = FileAccess.open("res://scripts/leveis/level_plantas.json", FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	plantas = JSON.new()
	var error = plantas.parse(content)
	if not error == OK:
		print("JSON Parse Error: ", plantas.get_error_message(), " in ", content, " at line ", plantas.get_error_line())
	else:
		
		if not plantas.data.aquario[0]:
			aquarioButton.get_node("Aquario").modulate = Color(0.1, 0.1, 0.1, 1)
			aquarioButton.disabled = false
		
		if not plantas.data.gatoPelo[0]:
			gatoPeloButton.get_node("GatoBolaDePelo").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoPeloButton.disabled = false
		
		if not plantas.data.gatoPau[0]:
			gatoPauButton.get_node("GatoDePau").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoPauButton.disabled = false
		
		if not plantas.data.gatoSonico[0]:
			gatoSonicoButton.get_node("GatoSonico").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoSonicoButton.disabled = false
		
		if not plantas.data.gatGarras[0]:
			gatoDeGarrasButton.get_node("GatoDeGarras").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoDeGarrasButton.disabled = false
		
		if not plantas.data.gatoBotas[0]:
			gatoDeBotasButton.get_node("GatoDeBotas").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoDeBotasButton.disabled = false
		
		if not plantas.data.caixaAreia[0]:
			caixaDeAreiaButton.get_node("CaixaDeAreia").modulate = Color(0.1, 0.1, 0.1, 1)
			caixaDeAreiaButton.disabled = false
	



func _process(_delta):
	pass


func setMoney(money):
	moneyLabel.text = str(money)
	


func limparEscolhas(escolha):
	mundo.selecionarGato(null)
	
	if escolha != 1:
		aquarioButton.deselaciona()
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



func _on_aquario_button_pressed():
	limparEscolhas(1)
	mundo.selecionarGato(aquario)


func _on_gato_bola_de_pelo_button_pressed():
	limparEscolhas(2)
	mundo.selecionarGato(gatoPelo)


func _on_gato_de_pau_button_pressed():
	if plantas.data.gatoPau[0]:
		limparEscolhas(3)
		mundo.selecionarGato(gatoPau)
	else:
		limparEscolhas(0)


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
