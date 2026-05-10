extends quest

@onready var blue_berry_item: Item = preload("res://resources/items/Bluebeary.tres")
@onready var teddy_bear_item: Item = preload("res://resources/items/TeddyBear.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready():
	pass

func activate():
	active=true

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({blue_berry_item: 5})):
		complete=true
		$/root/Main/Systems/Inventory.add_item({teddy_bear_item:1})
		$/root/Global.quests_complete +=1
		player.changeCredit(1)
		player.gainXP(35)
