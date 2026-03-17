extends Control

@onready var inventory = get_node("/root/Main/Systems/Inventory")
@onready var grid = $PanelContainer/Panel/VBoxContainer/GridContainer
@onready var xp = $PanelContainer/Panel/VBoxContainer/HBoxContainer/XP
@onready var social_credit = $"PanelContainer/Panel/VBoxContainer/HBoxContainer2/SocialCredit"
@onready var player = $/root/Main/Sort/PlayerEntities/Player

@export var item_slot_scene: PackedScene
@export var slot_count: int = 20

func _ready():
	inventory.inventory_updated.connect(update_ui)
	create_slots()
	update_ui()
	xp.max_value = 100
	xp.value = player.getXP()
	social_credit.text = str(player.getSocialCredit())



func update_ui():
	var slots = $PanelContainer/Panel/VBoxContainer/GridContainer.get_children()
	var item_list = inventory.items.keys()
	
	for i in range(slots.size()):
		if i < item_list.size():
			var item = item_list[i]
			var amount = inventory.items[item]
			slots[i].set_item(item, amount)
		else:
			slots[i].clear_item()
		xp.value = player.getXP()
		social_credit.text = str(player.getSocialCredit())

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Inventory")):
		visible=!visible

func create_slots():
	for i in range(slot_count):
		var slot = item_slot_scene.instantiate()
		grid.add_child(slot)
