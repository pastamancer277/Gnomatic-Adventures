extends Control

@onready var help_menu_scene = load("res://scenes/help_menu.tscn")
var count = 0
var help_menu = null
@onready var grid2 = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/VBoxContainer/Control2/Grid"

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if grid2 != null &&grid2.is_clicked()&& count ==0:
		grid2.visible = false
		help_menu = help_menu_scene.instantiate()
		add_child(help_menu)
		count += 1

func delete_menu():
	help_menu.queue_free()

func reset_count():
	count = 0
