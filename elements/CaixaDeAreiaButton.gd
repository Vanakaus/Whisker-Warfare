extends Button

var selected : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$CaixaDeAreia.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_pressed():
	if not selected:
		$CaixaDeAreia.play("action")
		selected = true
	else:
		release_focus()
		$CaixaDeAreia.play("idle")
		selected = false


func deselaciona():
		release_focus()
		$CaixaDeAreia.play("idle")
		selected = false
