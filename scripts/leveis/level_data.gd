extends Node

var level := 1
var numInimigos := 0
var dinheiroInicial := 200

var tileSizeX = 34
var tileSizeY = 24
var detectionIncrementX = tileSizeX/2
var detectionIncrementY = tileSizeY/2

var GridSizeX = 9
var GridSizeY = 5
var grid = {}


var robosCenas = [
	preload("res://robots/chappie/chappie.tscn"),
	preload("res://robots/eurobo/eurobo.tscn"),
	preload("res://robots/aspirobo/aspirobo.tscn"),
	preload("res://robots/roborrifador/roborrifador.tscn"),
	preload("res://robots/tanquino/tanquino.tscn"),
	]



var gatos = [
	{
		"codigo": "Aquario",
		"cena": preload("res://cats/aquario/aquario.tscn"),
		"Nome": "Aquário",
		"preco": 50,
		"desbloqueio": [true, true, true, true, true, true, true, true, true, true],
	},
	{
		"codigo": "GatoBolaDePelo",
		"cena": preload("res://cats/bolaDePelo/gatoPelo.tscn"),
		"Nome": "Gato Bola de Pelo",
		"preco": 100,
		"desbloqueio": [true, true, true, true, true, true, true, true, true, true],
	},
	{
		"codigo": "GatoDePau",
		"cena": preload("res://cats/pau/gatoPau.tscn"),
		"Nome": "Gato de Pau",
		"preco": 75,
		"desbloqueio": [false, false, false, true, true, true, true, true, true, true],
	},
	{
		"codigo": "GatoSonico",
		"cena": preload("res://cats/sonico/gatoSonico.tscn"),
		"Nome": "Gato Sonico",
		"preco": 125,
		"desbloqueio": [false, false, false, false, true, true, true, true, false, true],
	},
	{
		"codigo": "GatoDeGarras",
		"cena": preload("res://cats/garras/gatoGarras.tscn"),
		"Nome": "Gato de Garras",
		"preco": 125,
		"desbloqueio": [false, false, true, true, true, true, true, true, true, true],
	},
	{
		"codigo": "GatoDeBotas",
		"cena": preload("res://cats/botas/gatoBotas.tscn"),
		"Nome": "Gato de Botas",
		"preco": 250,
		"desbloqueio": [false, false, false, false, false, true, true, true, true, false],
	},
	{
		"codigo": "CaixaDeAreia",
		"cena": preload("res://cats/caixa/caixaDeAreia.tscn"),
		"Nome": "Caixa de Areia",
		"preco": 75,
		"desbloqueio": [false, true, true, true, true, true, true, false, true, true],
	},
]
