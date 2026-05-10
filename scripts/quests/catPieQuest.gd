extends quest

@onready var Pie_item: Item = preload("res://resources/items/Pie.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready():
	pass

func activate():
	active=true


func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({Pie_item: 1})):
		complete=true
		$/root/Global.quests_complete +=1
		player.addKeyword("catHasPie")
