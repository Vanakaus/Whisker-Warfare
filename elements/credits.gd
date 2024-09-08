extends Control

var counter = 0
var scroll_speed = 15

var credit_list = [
	["Desenvolvedores", "Vinícius Vieira \n Gustavo Favaro"],
	["Cenário", "Letícia Brito \n Gustavo Favaro"],
	["Áudio", "Letícia Brito \n Gustavo Favaro"],
	["Programa", "Godot \n Audacity"],
	["Inspiração", "Plants vs Zombies"],
	["Obrigado!", "Equipe"]
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()

func _process(delta: float) -> void:
	$ParallaxBackground/ParallaxLayer.motion_offset.x -= scroll_speed * delta

func _on_timer_timeout() -> void:
	$VBoxContainer/Title.text  = credit_list[counter][0]
	$VBoxContainer/Name.text  = credit_list[counter][1]
	$AnimationPlayer.play("FadeInNOut")
	counter +=1
	if counter == credit_list.size():
		$Timer.stop()
