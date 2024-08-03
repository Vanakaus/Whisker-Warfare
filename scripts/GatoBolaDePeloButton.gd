extends Button

var selected : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$GatoBolaDePelo.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if not selected:
		$GatoBolaDePelo.play("action")
		selected = true
	else:
		release_focus()
		$GatoBolaDePelo.play("idle")
		selected = false


func _on_gato_de_pau_button_pressed():
	pass # Replace with function body.


func _on_gato_sonic_button_pressed():
	pass # Replace with function body.
