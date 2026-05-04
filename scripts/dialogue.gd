extends CanvasLayer

var currentNPCDialogue: Node
@onready var panel_container = $PanelContainer
@onready var dialogue_text = $PanelContainer/HBoxContainer/VBoxContainer/DialogueText
@onready var buttons = $PanelContainer/HBoxContainer/VBoxContainer/HBoxContainer
@onready var texture_rect = $PanelContainer/HBoxContainer/MarginContainer/Control/TextureRect
var full_text = ""
var scroll_speed = 2
func _process(delta: float) -> void:
	pass

func dialogue(text: String, npc: Node, name: String, picture: PortableCompressedTexture2D):
	#$/root/Global.pause = true
	buttons.clearButtons()
	currentNPCDialogue=npc
	$PanelContainer/HBoxContainer/VBoxContainer/Name.text = name
	texture_rect.texture = picture
	texture_rect.custom_minimum_size = Vector2(50, 40) # Set specific pixel size
	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	show_text(text)


func _is_too_long()-> void:
	if full_text.length() < 45 or full_text[43] == " " or full_text[44] == " " or full_text[43] =="." or full_text[43] =="!" or full_text[44] =="." or full_text[44] =="!":
		dialogue_text.text += full_text.substr(0,45)
		full_text = full_text.substr(45, full_text.length()-45)
	else:
		var index = 0
		for i in range(45):
			if full_text[i] == " ":
				index = i
		dialogue_text.text += full_text.substr(0, index+1)
		full_text = full_text.substr(index+1, full_text.length()-(index+1))
	if full_text.length()>44:
		currentNPCDialogue.text += "\n"
		_is_too_long()
	else: 
		if full_text.length() == 1 and (full_text[0] =="." or full_text[0] =="!"or full_text[0] ==" ") :
			print("unnecessary")
		else: 
			dialogue_text.text += full_text.left(full_text.length())


func show_text(text: String):
	dialogue_text.text = text
	_is_too_long()
	panel_container.visible = true
	$/root/Global.pause = true

func setDialogueOption(text: String, key: int):
	buttons.setDialogueOption(text,key)

func playerResponse(key: int):
	panel_container.visible=false
	$/root/Main/Sort/PlayerEntities/Player.pauseAttack()
	currentNPCDialogue.playerResponse(key)

func clearDialogue(npc: Node):
	if(npc==currentNPCDialogue):
		currentNPCDialogue=null
		panel_container.visible=false
	buttons.clearButtons()

func reset():
	currentNPCDialogue=null
	panel_container.visible=false
	buttons.clearButtons()
