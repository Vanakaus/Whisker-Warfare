extends Button
@onready var price_label = $PriceLabel
var selected : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$GatoDeBotas.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_price(price):
	price_label.text= "$" + str(price)
	
func _on_pressed():
	if not self.disabled:
		if not selected:
			$GatoDeBotas.play("action")
			selected = true
		else:
			release_focus()
			$GatoDeBotas.play("idle")
			selected = false


func deselaciona():
		release_focus()
		$GatoDeBotas.play("idle")
		selected = false
