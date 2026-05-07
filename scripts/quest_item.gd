extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_quest(list: Array, text: String):
	$MarginContainer/Label.text = text + "     "
	print(get_child(0).get_child_count())
	for item in list:
		item.im.scale = Vector2(1.5, 1.5)
		item.text.add_theme_font_size_override("font_size", 8) 
		get_child(0).add_child(item)
	print(get_child(0).get_child_count())
	print(get_child_count())
