extends screen

@onready var is_focus = null
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_focus = $VBoxContainer/Button
	is_focus.grab_focus() 
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MeleeAttack") && get_viewport().gui_get_focus_owner() ==is_focus:
		$"/root/Global".pause = false
		is_focus = null
		queue_free()
