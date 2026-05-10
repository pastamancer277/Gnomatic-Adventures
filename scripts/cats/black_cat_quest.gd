extends quest

@onready var fish: Item = preload("res://resources/items/Fish.tres")
@onready var meat: Item = preload("res://resources/items/Meat.tres")
func activate():
	active=true
	print("running")

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({fish: 3, meat: 5})):
		complete=true
		$/root/Global.quests_complete +=1
		get_parent().get_parent().questComplete()
