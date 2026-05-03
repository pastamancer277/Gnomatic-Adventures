extends Node
var isFocus = null
var count = 0
@onready var inventory = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/Inventory"
@export var button: PackedScene
var text = false


func _process(delta: float) -> void:
	_check_length()
	if isFocus == null && get_children().size()>count and !text:
		isFocus = get_children().get(count)
		if isFocus != null:
			isFocus.grab_focus()
			$/root/Global.dialogue = true
	if(get_child_count() >0 and Input.is_action_just_pressed("MeleeAttack")):
		for child in get_children() :
			if child == isFocus:
				clearButtons()
				get_parent().get_parent().get_parent().get_parent().playerResponse(child.getKey())
				$/root/Global.dialogue = false
				
	if Input.is_action_just_pressed("MoveRight"):
		count+=1
		text = false
	elif Input.is_action_just_pressed("MoveLeft"):
		count-=1
		text = false
	if count >= get_child_count():
		count = 0
	if count <0:
		count = 0
	if get_children().size()>count and !text:
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

func clearButtons():
	if($/root/Global != null):
		$/root/Global.pause = false
	inventory.visible = true
	for child in get_children():
		child.queue_free()
func _check_length():
	if get_parent().size.x >260:
		var length = 0
		var c = null
		for child in get_children():
			if child.size.x > length:
				length = child.size.x
				c = child
		var text = c.text.length()
		c.text = c.text.substr(0,text/2) + "\n" + c.text.substr(text/2, text)
