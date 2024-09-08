extends Node2D

@onready var mundo = $/root/World
@onready var moneyLabel = get_node('FishQtd')
@onready var levelLabel = get_node('LevelLabel')


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
	levelLabel.text = "Level " + str(LevelData.level)
	
	#Carregando o script do level 1
	var file = FileAccess.open("res://scripts/leveis/level_plantas.json", FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	plantas = JSON.new()
	var error = plantas.parse(content)
	if not error == OK:
		print("JSON Parse Error: ", plantas.get_error_message(), " in ", content, " at line ", plantas.get_error_line())
	else:
		if plantas.data.aquario[LevelData.level-1]:
			aquarioButton.set_price(plantas.data.precos.aquario)
		else:
			aquarioButton.get_node("Aquario").modulate = Color(0.1, 0.1, 0.1, 1)
			aquarioButton.disabled = false
		
		if plantas.data.gatoPelo[LevelData.level-1]:
			gatoPeloButton.set_price(plantas.data.precos.gatoPelo)
		else:
			gatoPeloButton.get_node("GatoBolaDePelo").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoPeloButton.disabled = false
		
		if plantas.data.gatoPau[LevelData.level-1]:
			gatoPauButton.set_price(plantas.data.precos.gatoPau)
		else:
			gatoPauButton.get_node("GatoDePau").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoPauButton.disabled = false
		
		if plantas.data.gatoSonico[LevelData.level-1]:
			gatoSonicoButton.set_price(plantas.data.precos.gatoSonico)
		else:
			gatoSonicoButton.get_node("GatoSonico").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoSonicoButton.disabled = false
		
		if plantas.data.gatGarras[LevelData.level-1]:
			gatoDeGarrasButton.set_price(plantas.data.precos.gatoGarras)
		else:
			gatoDeGarrasButton.get_node("GatoDeGarras").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoDeGarrasButton.disabled = false
		
		if plantas.data.gatoBotas[LevelData.level-1]:
			gatoDeBotasButton.set_price(plantas.data.precos.gatoBotas)
		else:
			gatoDeBotasButton.get_node("GatoDeBotas").modulate = Color(0.1, 0.1, 0.1, 1)
			gatoDeBotasButton.disabled = false
		
		if plantas.data.caixaAreia[LevelData.level-1]:
			caixaDeAreiaButton.set_price(plantas.data.precos.caixaAreia)
		else:
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
	if plantas.data.aquario[LevelData.level-1]:
		limparEscolhas(1)
		mundo.selecionarGato(aquario)
	else:
		limparEscolhas(0)


func _on_gato_bola_de_pelo_button_pressed():
	if plantas.data.gatoPelo[LevelData.level-1]:
		limparEscolhas(2)
		mundo.selecionarGato(gatoPelo)
	else:
		limparEscolhas(0)


func _on_gato_de_pau_button_pressed():
	if plantas.data.gatoPau[LevelData.level-1]:
		limparEscolhas(3)
		mundo.selecionarGato(gatoPau)
	else:
		limparEscolhas(0)


func _on_gato_sonic_button_pressed():
	if plantas.data.gatoSonico[LevelData.level-1]:
		limparEscolhas(4)
		mundo.selecionarGato(gatoSonico)
	else:
		limparEscolhas(0)


func _on_gato_de_garras_button_pressed():
	if plantas.data.gatGarras[LevelData.level-1]:
		limparEscolhas(5)
		mundo.selecionarGato(gatoDeGarras)
	else:
		limparEscolhas(0)


func _on_gato_de_botas_button_pressed():
	if plantas.data.gatoBotas[LevelData.level-1]:
		limparEscolhas(6)
		mundo.selecionarGato(gatoDeBotas)
	else:
		limparEscolhas(0)


func _on_caixa_de_areia_button_pressed():
	if plantas.data.caixaAreia[LevelData.level-1]:
		limparEscolhas(7)
		mundo.selecionarGato(caixaDeAreia)
	else:
		limparEscolhas(0)
