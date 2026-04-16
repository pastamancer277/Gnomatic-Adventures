extends PanelContainer

@onready var isFocus = null
var clicked = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !$"/root/Global".pause and !($"/root/Global".dialogue) and(Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("ui_up")|| Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right")):
		isFocus = $Button
		isFocus.grab_focus()
	if !$"/root/Global".pause and !$/root/Global.dialogue and isFocus != null and Input.is_action_just_pressed("ui_accept"):
		clicked = true
	if $/root/Global.dialogue || $/root/Global.pause:
		isFocus = null


func is_clicked():
	return clicked
	
func change_clicked() -> void:
	clicked = false
