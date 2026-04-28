extends Node

var player_alive=true
var pause = true
var dialogue = false
@onready var player = get_node("/root/Main/Sort/PlayerEntities/Player")

var cur_area := ""
var scene_transit=false

var player_start_x=53
var player_start_y=37

var game_first_load=true

func _ready():
	change_area("StartingForest")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Load Data"):
		$/root/SaveManager.loadGame()

func finish_scene_change(name: String):
	if scene_transit:
		scene_transit=false
		game_first_load=false
		setPlayerPos(name)
		cur_area=name
		
		change_area(name)

func change_area(area_name: String) -> void:
	for area in get_tree().get_nodes_in_group("area"):
		if area.name == area_name:
			area.set_active(true)
			cur_area = area.name
		else:
			area.set_active(false)

func setPlayerPos(name: String):
	get_node("/root/Main/Sort/Areas/"+name).enterFrom(cur_area)
	player.setAllyPos()

func getPaused():
	return pause

func getCurArea():
	return cur_area

func resetGame():
	game_first_load = true
	change_area("StartingForest")
	player.global_position.x=player_start_x
	player.global_position.y=player_start_y
	reset_all_nodes(get_node("/root"))

func reset_all_nodes(root_node):
	if root_node.has_method("reset"):
		root_node.reset()
	
	for child in root_node.get_children():
		reset_all_nodes(child)

func saveData():
	var data={
		"loc" = cur_area,
	}
	$/root/SaveManager.addSaveData("World", name, data)

func loadData():
	var data = $/root/SaveManager.getData("World", name)
	cur_area= data.get("loc", cur_area)
	change_area(cur_area)
	for node in $/root/Main/Sort/PlayerEntities.get_children():
		if(not node.name=="Player"):
			node.queue_free()

func multiple_popups():
	if $/root/Main/UI/Popups.get_child_count() >1:
		var num = $/root/Main/UI/Popups.get_child_count()
		var pos = 210 - 10*num
		for child in $/root/Main/UI/Popups.get_children():
			child.global_position.y = pos
			num-=1
			pos = 210 - 10*num
