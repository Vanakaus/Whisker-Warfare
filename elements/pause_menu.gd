extends Control

@onready var main = $"../"

func _on_button_pressed() -> void:
	main.pauseMenu()
