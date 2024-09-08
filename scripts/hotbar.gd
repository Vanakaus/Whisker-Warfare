extends Node2D

@onready var mundo = $/root/World
@onready var moneyLabel = get_node('FishQtd')
@onready var levelLabel = get_node('LevelLabel')



@onready var botoes = [
	$AquarioButton,
	$GatoBolaDePeloButton,
	$GatoDePauButton,
	$GatoSonicButton,
	$GatoDeGarrasButton,
	$GatoDeBotasButton,
	$CaixaDeAreiaButton,
]

@onready var gatoEscolhido = 0



func _ready():
	levelLabel.text = "Level " + str(LevelData.level)
	
	
	for i in range(LevelData.gatos.size()):
		
		if LevelData.gatos[i].desbloqueio[LevelData.level-1]:
			botoes[i].set_price(LevelData.gatos[i].preco)
		else:
			botoes[i].get_node(LevelData.gatos[i].codigo).modulate = Color(0.1, 0.1, 0.1, 1)
			botoes[i].disabled = false
		
	



func _process(_delta):
	pass


func setMoney(money):
	moneyLabel.text = str(money)
	


func escolher(escolha):
	gatoEscolhido = escolha
	mundo.selecionarGato(escolha)
	
	if escolha != 1:
		botoes[0].deselaciona()
	if escolha != 2:
		botoes[1].deselaciona()
	if escolha != 3:
		botoes[2].deselaciona()
	if escolha != 4:
		botoes[3].deselaciona()
	if escolha != 5:
		botoes[4].deselaciona()
	if escolha != 6:
		botoes[5].deselaciona()
	if escolha != 7:
		botoes[6].deselaciona()



func _on_aquario_button_pressed():
	if LevelData.gatos[0].desbloqueio[LevelData.level-1] and gatoEscolhido != 1:
		escolher(1)
	else:
		escolher(0)


func _on_gato_bola_de_pelo_button_pressed():
	if LevelData.gatos[1].desbloqueio[LevelData.level-1] and gatoEscolhido != 2:
		escolher(2)
	else:
		escolher(0)


func _on_gato_de_pau_button_pressed():
	if LevelData.gatos[2].desbloqueio[LevelData.level-1] and gatoEscolhido != 3:
		escolher(3)
	else:
		escolher(0)


func _on_gato_sonic_button_pressed():
	if LevelData.gatos[3].desbloqueio[LevelData.level-1] and gatoEscolhido != 4:
		escolher(4)
	else:
		escolher(0)


func _on_gato_de_garras_button_pressed():
	if LevelData.gatos[4].desbloqueio[LevelData.level-1] and gatoEscolhido != 5:
		escolher(5)
	else:
		escolher(0)


func _on_gato_de_botas_button_pressed():
	if LevelData.gatos[5].desbloqueio[LevelData.level-1] and gatoEscolhido != 6:
		escolher(6)
	else:
		escolher(0)


func _on_caixa_de_areia_button_pressed():
	if LevelData.gatos[6].desbloqueio[LevelData.level-1] and gatoEscolhido != 7:
		escolher(7)
	else:
		escolher(0)
