extends quest

@onready var fur_item: Item = preload("res://resources/items/Fur.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready():
	pass

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({fur_item: 6})):
		complete=true
		player.changeCredit(3)
