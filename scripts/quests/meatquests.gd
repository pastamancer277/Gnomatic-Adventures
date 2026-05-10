extends quest

@onready var meat_item: Item = preload("res://resources/items/Meat.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready():
	pass

func activate():
	active=true

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({meat_item: 3})):
		complete=true
		$/root/Global.quests_complete +=1
		player.changeCredit(3)
