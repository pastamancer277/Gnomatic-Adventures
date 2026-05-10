extends quest

@onready var fur_item: Item = preload("res://resources/items/Fur.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player


func _ready():
	pass

func activate():
	active=true

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({fur_item: 6})):
		complete=true
		$/root/Global.quests_complete +=1
		player.changeCredit(3)
