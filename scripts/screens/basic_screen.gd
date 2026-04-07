extends Control

class_name screen

@onready var isFocus = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("ui_up")|| Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right"):
		isFocus = $Button
		isFocus.grab_focus()
	if isFocus != null and Input.is_action_just_pressed("ui_accept"):
		$"/root/Global".pause = false
		isFocus = null
		queue_free() 
	
