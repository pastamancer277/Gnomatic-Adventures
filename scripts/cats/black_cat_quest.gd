extends quest

@onready var fish=preload("res://resources/items/Fish.tres")
@onready var meat=preload("res://resources/items/Meat.tres")
@onready var quest_menu = $"../../../../../../../UI/HelpMenusInterface"/VBoxContainer/HBoxContainer/QuestMenu
@onready var quest_item_scene = load("res://scenes/quest_item.tscn")
@onready var item_slot_scene = load("res://scenes/item_slot.tscn")
var  item_slot1 = null
var  item_slot2 = null
var quest_item = null
func activate():
	active=true
	print("running")
	quest_item = quest_item_scene.instantiate()
	item_slot1 = item_slot_scene.instantiate()
	item_slot1.set_item(fish, 3)
	item_slot2 = item_slot_scene.instantiate()
	item_slot2.set_item(meat, 5)
	var items = [item_slot1, item_slot2]
	quest_item.new_quest(items, "Black Cat Quest")
	quest_menu.add_child(quest_item)

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({fish: 3, meat: 5})):
		complete=true
		quest_item.queue_free()
		get_parent().get_parent().questComplete()
