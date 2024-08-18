extends MarginContainer

func gameover():
	# talvez limpar o cenário ou só fazer os bicho parar tem que ver isso dps
	print("entrou na func do gameover")
	$VBoxContainer/Label.text = "Game Over"
	$VBoxContainer/Label2.text = "Os robôs superaram a defensa felina."
	visible = true
	get_tree().paused = true

func gamewon():
	$VBoxContainer/Label.text = "Level Concluído!"
	$VBoxContainer/Label2.text =  "Os gatinhos salvam o dia! :D"
	visible = true
	get_tree().paused = true
