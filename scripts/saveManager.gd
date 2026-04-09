extends Node

signal loaded

var savedData: Dictionary
const SAVE_PATH = "user://savegame.save"

func _ready():
	savedData = {
		"NPCs" = {},
		"Player" = {},
		"Quests" = {},
		"World" = {},
		"Dialogue" = {},
		"Chests" = {}
	}

func setSaveData(access: String, data: Dictionary):
	if savedData.has(access):
		savedData[access]=data
	else:
		savedData.assign(data)

func addSaveData(access: String, key: String, data):
	if savedData.has(access):
		savedData[access][key] = data

func saveGame():
	save_all_nodes(get_node("/root"))
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(savedData)
	file.store_line(json_string)
	file.close()

func loadGame():
	print("run")
	if not FileAccess.file_exists(SAVE_PATH):
		return null
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if(file==null):
		pass
	
	var content = file.get_as_text()
	var data = JSON.parse_string(content)
	
	if data is Dictionary:
		savedData = data
	
	load_all_nodes(get_node("/root"))
	loaded.emit()

func getData(access: String, key: String):
	var data = null
	if(savedData.has(access)):
		data = savedData[access].get(key)
	if(data != null):
		return data
	else:
		return {}

func getAccessData(access: String):
	if(savedData.has(access)):
		return savedData[access]

func load_all_nodes(root_node):
	if root_node.has_method("loadData"):
		root_node.loadData()
	
	for child in root_node.get_children():
		load_all_nodes(child)

func save_all_nodes(root_node):
	if root_node.has_method("saveData"):
		root_node.saveData()
	
	for child in root_node.get_children():
		save_all_nodes(child)

func saveData():
	pass
func loadData():
	pass
