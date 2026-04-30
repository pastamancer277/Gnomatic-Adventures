extends Node

class_name dialogue

@onready var gold: Item = preload("res://resources/items/Gold.tres")

var run=1
var dialogueBox
var tex = null
var person_name: String = ""

func _ready():
	dialogueBox=$/root/Main/UI/Dialogue

func reset():
	run=1
	for quest in get_node("../Quests").get_children():
		quest.reset()

func saveData():
	$/root/SaveManager.addSaveData("Dialogue", get_parent().name, {"run" = run})

func loadData():
	var data = $/root/SaveManager.getData("Dialogue", get_parent().name)
	run = data.get("run", 1)
