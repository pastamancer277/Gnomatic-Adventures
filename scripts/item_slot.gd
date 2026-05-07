extends TextureRect
@onready var im = $Sprite2D
@onready var text = $AmountLabel
func set_item(item: Item, amount: int):
	im = $Sprite2D
	text = $AmountLabel
	$Sprite2D.texture = item.icon
	$AmountLabel.text = str(amount)
	visible = true

func clear_item():
	visible = false
