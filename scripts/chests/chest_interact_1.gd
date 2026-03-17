extends Node

@onready var key_item: Item = preload("res://resources/items/BasicKey.tres")
@onready var fish: Item=preload("res://resources/items/Fish.tres")

func interact(player):
	if $/root/Main/Systems/Inventory.tryRemove({key_item: 1}):
		get_node("../AnimatedSprite2D").play("open")
		$/root/Main/Systems/Inventory.add_item({fish: 3})
