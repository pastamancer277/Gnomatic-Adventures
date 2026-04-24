extends screen

var is_focus = null
@onready var grid = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/VBoxContainer/Control2/Grid"
@onready var control = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/VBoxContainer/Control2"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_focus = $Button
	is_focus.grab_focus()
	$"/root/Global".pause = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("ui_up")|| Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right"):
		is_focus = $Button
		is_focus .grab_focus()
	if is_focus  != null and Input.is_action_just_pressed("MeleeAttack"):
		grid.change_clicked()
		grid.visible = true
		control.reset_count()
		$"/root/Global".pause = false;
		queue_free()
