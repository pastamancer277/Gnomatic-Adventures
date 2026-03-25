extends Node

signal inventory_updated

var items: Dictionary = {}
var max_slots := 20

@onready var player = get_node("/root/Main/Sort/PlayerEntities/Player")

func _ready():
	player.resetGame.connect(func(): removeAllItems(items))

func add_item(item: Dictionary) -> bool:
	for item_name in item.keys():
		if(items.has(item_name)):
			items[item_name]+=item[item_name]
		else: if(items.size()<max_slots):
			items[item_name]=item[item_name]
		else:
			return false
	
	inventory_updated.emit()
	return true

func hasItems(required_items: Dictionary) -> bool:
	for item_name in required_items.keys():
		var required_amount = required_items[item_name]
		
		if not items.has(item_name):
			return false
		
		if items[item_name] < required_amount:
			return false
		
	return true

func tryRemove(required_items: Dictionary) -> bool:
	if(hasItems(required_items)):
		removeAllItems(required_items)
		return true
	else:
		return false

func removeAllItems(required_items: Dictionary):
	for item in required_items:
		removeItems(item, required_items[item])

func removeItems(item: Item, amount: int = 1):
	if not items.has(item):
		return
	items[item] -= amount
	
	if items[item] <= 0:
		items.erase(item)
	inventory_updated.emit()
