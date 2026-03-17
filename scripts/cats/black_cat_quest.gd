extends quest

@onready var fish=preload("res://resources/items/Fish.tres")
@onready var meat=preload("res://resources/items/Meat.tres")

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({fish: 3})):
		complete=true
	get_parent().get_parent().questComplete()
