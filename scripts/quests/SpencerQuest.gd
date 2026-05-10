extends quest

@onready var coin_item: Item = preload("res://resources/items/Gold.tres")
@onready var meat_item: Item = preload("res://resources/items/Meat.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player


func _ready():
	pass

func activate():
	active=true


func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({coin_item: 3}) and$/root/Main/Systems/Inventory.tryRemove({meat_item: 2}) ):
		complete=true
		player.gainXP(75)
		player.changeCredit(4)
