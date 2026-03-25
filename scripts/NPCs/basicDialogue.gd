extends Node

class_name dialogue

var run=1
var dialogueBox

func _ready():
	dialogueBox=$/root/Main/UI/Dialogue

func reset():
	run=1
	for quest in get_node("../Quests").get_children():
		quest.reset()
