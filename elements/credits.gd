extends Control

var counter = 0
var scroll_speed = 15

var credit_list = [
	["Desenvolvedores", "Vinícius Vieira \n Gustavo Favaro"],
	["Arte", "Letícia Brito \n Gustavo Favaro"],
	["Áudio", "Letícia Brito \n Gustavo Favaro\n 3GRK4 (Casual Music Game)"],
	["Programas utilizados", "Godot \n Audacity \nFL Studio"],
	["Obrigado por jogar!", "Equipe"]
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CreditsSong.play()
	$Timer.start()
	$AnimationPlayer.play("SkipCutsceneText")

func _process(delta: float) -> void:
	$ParallaxBackground/ParallaxLayer.motion_offset.x -= scroll_speed * delta
	if Input.is_action_just_pressed("backspace") or not $CreditsSong.is_playing():
		end_credits()

func _on_timer_timeout() -> void:
	$VBoxContainer/Title.text  = credit_list[counter][0]
	$VBoxContainer/Name.text  = credit_list[counter][1]
	if counter == 4:
		$AnimationPlayer.play("Fixated")
	else:
		$AnimationPlayer.play("Fade")
	counter +=1
	if counter == credit_list.size():
		$Timer.stop()

func end_credits() -> void:
	get_tree().change_scene_to_file("res://elements/main_menu.tscn")
