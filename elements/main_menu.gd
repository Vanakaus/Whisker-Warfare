extends Control

func _on_game_start_pressed() -> void:
	get_tree().change_scene_to_file("res://level.tscn")


func _on_instructions_pressed() -> void:
	get_tree().change_scene_to_file("res://elements/instructions.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
