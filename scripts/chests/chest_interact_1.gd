extends Node

@onready var key_item: Item = preload("res://resources/items/BasicKey.tres")
@onready var fish: Item=preload("res://resources/items/Fish.tres")

func interact(player):
	if $/root/Main/Systems/Inventory.tryRemove({key_item: 1}):
		get_node("../AnimatedSprite2D").play("open")
		$/root/Main/Systems/Inventory.add_item({fish: 3})
		get_parent().setOpen(true)
		var popup_scene = load("res://scenes/popups.tscn").instantiate()
		$"/root/Main/UI/Popups".add_child(popup_scene)
		popup_scene.set_text("You gained fish! ")
		$/root/Global.multiple_popups()
