extends quest

@onready var wood_item: Item = preload("res://resources/items/Wood.tres")
@onready var key_item: Item = preload("res://resources/items/BasicKey.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready():
	pass

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({wood_item: 3})):
		complete=true
		player.gainXP(100)
		player.changeCredit(1)
