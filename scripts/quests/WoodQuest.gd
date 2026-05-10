extends quest

@onready var wood_item: Item = preload("res://resources/items/Wood.tres")
@onready var key_item: Item = preload("res://resources/items/BasicKey.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player


func _ready():
	pass

func activate():
	active=true


func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({wood_item: 1})):
		complete=true
		player.gainXP(100)
		$/root/Global.quests_complete +=1
		player.changeCredit(1)
