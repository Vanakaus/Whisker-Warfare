extends Control

func _ready() -> void:
	$MenuMusic.play()
	$CanvasLayer/Instructions.hide()

func _on_game_start_pressed() -> void:
	$MenuMusic.stop()
	get_tree().change_scene_to_file("res://level.tscn")


func _on_instructions_pressed() -> void:
	$MenuElements.hide()
	$MenuBackground.hide()
	$CanvasLayer/Instructions.show()


func _on_quit_pressed() -> void:
	$MenuMusic.stop()
	get_tree().quit()


func _on_credits_pressed() -> void:
	$MenuMusic.stop()
	get_tree().change_scene_to_file("res://elements/credits.tscn")


func _on_voltar_pressed() -> void:
	$CanvasLayer/Instructions.hide()
	$MenuElements.show()
	$MenuBackground.show()
