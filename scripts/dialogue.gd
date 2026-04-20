extends CanvasLayer

var currentNPCDialogue: Node
@onready var panel_container = $VBoxContainer/Panel
@onready var dialogue_text = $VBoxContainer/Panel/DialogueText
var scroll_speed = 2
func _process(delta: float) -> void:
	pass

func dialogue(text: String, npc: Node):
	$VBoxContainer/HBoxContainer.clearButtons()
	currentNPCDialogue=npc
	show_text(text)

func show_text(text: String):
	dialogue_text.text = text
	panel_container.visible = true
	print(panel_container.visible )

func setDialogueOption(text: String, key: int):
	$VBoxContainer/HBoxContainer.setDialogueOption(text,key)

func playerResponse(key: int):
	panel_container.visible=false
	currentNPCDialogue.playerResponse(key)

func clearDialogue(npc: Node):
	if(npc==currentNPCDialogue):
		currentNPCDialogue=null
		panel_container.visible=false
		$VBoxContainer/HBoxContainer.clearButtons()

func reset():
	currentNPCDialogue=null
	panel_container.visible=false
	$VBoxContainer/HBoxContainer.clearButtons()
