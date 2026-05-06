extends TextureRect

func set_item(item: Item, amount: int):
	$Sprite2D.texture = item.icon
	print(item.icon.get_size())
	$AmountLabel.text = str(amount)
	visible = true

func clear_item():
	visible = false
