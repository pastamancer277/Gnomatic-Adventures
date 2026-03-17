extends CanvasLayer

var currentNPCDialogue

func dialogue(text: String, npc: Node):
	currentNPCDialogue=npc
	show_text(text)

func show_text(text: String):
	$VBoxContainer/Panel/DialogueText.text = text
	$VBoxContainer/Panel.visible = true
	print($VBoxContainer/Panel.visible)

func setDialogueOption(text: String, key: int):
	$VBoxContainer/HBoxContainer.setDialogueOption(text,key)

func playerResponse(key: int):
	$VBoxContainer/Panel.visible=false
	currentNPCDialogue.playerResponse(key)

func clearDialogue():
	currentNPCDialogue=null
	$VBoxContainer/Panel.visible=false
	$VBoxContainer/HBoxContainer.clearButtons()
