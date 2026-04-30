extends CharacterBody2D

class_name chest

var player
var open=false
@export var resource: chests
var reqs = {}
var items = {}

func _ready() -> void:
	name = resource.name
	for item in resource.require:
		if reqs.has(item):
			reqs[item] += 1
		else:
			reqs[item] = 1
	for item in resource.items:
		if items.has(item):
			items[item] += 1
		else:
			items[item] = 1

func _process(delta):
	if !player==null and Input.is_action_just_pressed("Interact") and not open:
		if($/root/Main/Systems/Inventory.tryRemove(reqs)):
			get_node("AnimatedSprite2D").play("open")
			$/root/Main/Systems/Inventory.add_item(items)
			setOpen(true)
			var popup_scene = load("res://scenes/popups.tscn").instantiate()
			$"/root/Main/UI/Popups".add_child(popup_scene)
			popup_scene.set_text("You gained some items!")
			$/root/Global.multiple_popups()

func setOpen(o):
	open=o

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player=body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player=null

func saveData():
	$"/root/SaveManager".addSaveData("Chests", name, {"open" = open})

func loadData():
	var data = $"/root/SaveManager".getData("Chests", name)
	open = data.get("open", false)
	if(open == true):
		$AnimatedSprite2D.play("setOpen")
	else:
		$AnimatedSprite2D.play("setClosed")
