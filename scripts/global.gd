extends Node

var player_alive=true
var pause = true
@onready var player = $/root/Main/Sort/PlayerEntities/Player

var cur_area := ""
var scene_transit=false

var player_enter_f1_x=358.5
var player_enter_f1_y=176.5
var player_exit_f1_x=-105
var player_exit_f1_y=11
var player_start_x=53
var player_start_y=37
var player_f2_c1_x=200
var player_f2_c1_y=20

var game_first_load=true

func _ready():
	change_area("Forest2")

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
	if(name=="Forest1"):
		player.position.x=player_enter_f1_x
		player.position.y=player_enter_f1_y
	if(name=="Forest2"&&cur_area=="Forest1"):
		player.position.x=player_exit_f1_x
		player.position.y=player_exit_f1_y
	if(name=="City1"&&cur_area=="Forest2"):
		player.position.x=player_exit_f1_x
		player.position.y=player_exit_f1_y
	player.setAllyPos()

func getPaused():
	return pause
