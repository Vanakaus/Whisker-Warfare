extends Button

var selected : bool = false
# Called when the node enters the scene tree for the first time.
@onready var price_label = $PriceLabel
func _ready():
	$GatoDePau.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func set_price(price):
	price_label.text= "$" + str(price)

func _on_pressed():
	if not self.disabled:
		if not selected:
			$GatoDePau.play("action")
			selected = true
		else:
			release_focus()
			$GatoDePau.play("idle")
			selected = false


func deselaciona():
		release_focus()
		$GatoDePau.play("idle")
		selected = false
