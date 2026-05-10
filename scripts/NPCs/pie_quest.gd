extends quest

@onready var Pie_item: Item = preload("res://resources/items/Meat.tres")
@onready var Coin_item: Item = preload("res://resources/items/Gold.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready():
	pass

func activate():
	active=true


func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({Pie_item: 3})):
		complete=true
		$/root/Global.quests_complete +=1
		$/root/Main/Systems/Inventory.add_item({Coin_item:5})
