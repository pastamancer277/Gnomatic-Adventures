extends Node
var isFocus = null
var count = 0
@onready var inventory = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/Inventory"
@onready var grid = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/VBoxContainer/Control2/Grid"
@export var button: PackedScene


func _process(delta: float) -> void:
	if isFocus == null:
		isFocus = get_children().get(count)
		if isFocus != null:
			isFocus.grab_focus()
			$/root/Global.dialogue = true
	if(get_child_count() >0 and Input.is_action_just_pressed("ui_accept")):
		for child in get_children() :
			if child == isFocus:
				clearButtons()
				get_parent().get_parent().playerResponse(child.getKey())
				$/root/Global.dialogue = false
				
	if Input.is_action_just_pressed("ui_right"):
		count+=1
	elif Input.is_action_just_pressed("ui_left"):
		count-=1
	if count >= get_child_count():
		count = 0
	if count <0:
		count = 0
	if get_children().get(count) != null:
		isFocus = get_children().get(count)
		isFocus.grab_focus()

func setDialogueOption(text: String, key: int):
	var child = button.instantiate()
	child.setKey(key)
	add_child(child)
	child.text=text
	child.add_theme_font_size_override("font_size", 7)
	child.visible=true
	inventory.visible = false
	grid.visible = false

func clearButtons():
	inventory.visible = true
	grid.visible = true
	for child in get_children():
		child.queue_free()
