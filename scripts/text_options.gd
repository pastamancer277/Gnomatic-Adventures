extends Node

func _process(delta: float) -> void:
	var count=0;
	if(get_child_count() >0):
		for child in get_children() :
			if child.button_pressed:
				clearButtons()
				get_parent().get_parent().playerResponse(count)
			else:
				count+=1

func setDialogueOption(text: String, key: int):
	var child = Button.new()
	add_child(child)
	child.text=text
	child.visible=true

func clearButtons():
	for child in get_children():
		child.queue_free()
