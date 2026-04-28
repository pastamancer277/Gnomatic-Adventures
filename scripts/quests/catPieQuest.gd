extends quest

@onready var Pie_item: Item = preload("res://resources/items/Pie.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready():
	pass

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({Pie_item: 3})):
		complete=true
		player.changeCredit(1)
