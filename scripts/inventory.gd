extends Control

@onready var inventory = get_node("/root/Main/Systems/Inventory")
@onready var grid = $PanelContainer/HBoxContainer/GridContainer
@onready var xp = $PanelContainer/HBoxContainer/XP
@onready var xp_label = $PanelContainer/HBoxContainer/Label
@onready var social_credit = $"PanelContainer/HBoxContainer/SocialCredit"
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

func _process(delta: float) -> void:
	xp.value = player.getXP()
	xp.max_value = player.xpToLevel
	xp_label.text = "Level: " + str(player.level)
	social_credit.text = str(player.getSocialCredit())

func update_ui():
	var slots = $PanelContainer/HBoxContainer/GridContainer.get_children()
	var item_list = inventory.items.keys()
	
	for i in range(slots.size()):
		if i < item_list.size():
			var item = item_list[i]
			var amount = inventory.items[item]
			slots[i].set_item(item, amount)
		else:
			slots[i].clear_item()

func create_slots():
	for i in range(slot_count):
		var slot = item_slot_scene.instantiate()
		grid.add_child(slot)
