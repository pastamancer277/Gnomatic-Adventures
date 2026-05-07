extends quest

@onready var Pie_item: Item = preload("res://resources/items/Pie.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var quest_menu = $"../../../../../../../UI/HelpMenusInterface"/VBoxContainer/HBoxContainer/QuestMenu
@onready var quest_item_scene = load("res://scenes/quest_item.tscn")
@onready var item_slot_scene = load("res://scenes/item_slot.tscn")
var  item_slot = null
var quest_item = null
func _ready():
	pass

func activate():
	active=true
	quest_item = quest_item_scene.instantiate()
	item_slot = item_slot_scene.instantiate()
	item_slot.set_item(Pie_item, 1)
	var items = [item_slot]
	quest_item.new_quest(items, "Pie Quest")
	quest_menu.add_child(quest_item)


func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({Pie_item: 1})):
		complete=true
		quest_item.queue_free()
		player.addKeyword("catHasPie")
