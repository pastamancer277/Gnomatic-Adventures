extends TextureRect

func set_item(item: Item, amount: int):
	$Sprite2D.texture = item.icon
	$AmountLabel.text = str(amount)
	visible = true

func clear_item():
	visible = false
