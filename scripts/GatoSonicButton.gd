extends Button

var selected : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$GatoSonico.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	if not selected:
		$GatoSonico.play("action")
		selected = true
	else:
		release_focus()
		$GatoSonico.play("idle")
		selected = false
