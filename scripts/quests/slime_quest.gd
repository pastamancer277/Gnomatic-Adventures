extends quest

@onready var slimeball_item: Item = preload("res://resources/items/Fur.tres")
@onready var key_item: Item = preload("res://resources/items/BasicKey.tres")
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
	item_slot.set_item(slimeball_item, 6)
	var items = [item_slot]
	quest_item.new_quest(items, "Fur Quest")
	quest_menu.add_child(quest_item)
func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({slimeball_item: 6})):
		complete=true
		$/root/Main/Systems/Inventory.add_item({key_item:1})
		quest_item.queue_free()
		player.changeCredit(3)
