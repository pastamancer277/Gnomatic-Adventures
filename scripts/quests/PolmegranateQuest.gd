extends quest

@onready var polmegranate_item: Item = preload("res://resources/items/Polmegranate.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready():
	pass

func tryComplete():
	if($/root/Main/Systems/Inventory.tryRemove({polmegranate_item: 1})):
		complete=true
		player.changeCredit(1)
