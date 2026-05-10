extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_quest(list: Array, text: String, quest_text: String):
	$VBoxContainer/MarginContainer/QuestName.text = text + ""
	$VBoxContainer/QuestLabel.text = quest_text
	for item in list:
		item.im.scale = Vector2(1.0, 1.0) 
		var new_label = Label.new()
		new_label.text = item.text.text + ""
		new_label.add_theme_font_size_override("font_size", 4)
		new_label.add_theme_constant_override("outline_size", 2)
		new_label.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_SHRINK_END
		new_label.size_flags_vertical =  Control.SIZE_SHRINK_END
		get_child(0).get_child(0).add_child(new_label)
		get_child(0).get_child(0).add_child(item)
		item.text.visible = false
		#item.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_SHRINK_END
		#item.size_flags_vertical =  Control.SIZE_SHRINK_END
