extends quest

@onready var teddy: Item = preload("res://resources/items/TeddyBear.tres")
func activate():
	active=true
	
func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({teddy: 1})):
		complete=true
		get_parent().get_parent().questComplete()
