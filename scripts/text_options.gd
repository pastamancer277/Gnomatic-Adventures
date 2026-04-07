extends Node

@onready var inventory = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/Inventory"
@export var button: PackedScene

func _process(delta: float) -> void:
	if(get_child_count() >0):
		for child in get_children() :
			if child.button_pressed:
				clearButtons()
				get_parent().get_parent().playerResponse(child.getKey())

func setDialogueOption(text: String, key: int):
	var child = button.instantiate()
	child.setKey(key)
	add_child(child)
	child.text=text
	child.add_theme_font_size_override("font_size", 7)
	child.visible=true
	inventory.visible = false

func clearButtons():
	inventory.visible = true
	for child in get_children():
		child.queue_free()
