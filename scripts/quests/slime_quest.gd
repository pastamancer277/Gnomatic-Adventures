extends quest

@onready var slimeball_item: Item = preload("res://resources/items/Slimeball.tres")
@onready var key_item: Item = preload("res://resources/items/BasicKey.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready():
	pass

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({slimeball_item: 3})):
		complete=true
		$/root/Main/Systems/Inventory.add_item({key_item:1})
		player.changeCredit(3)
