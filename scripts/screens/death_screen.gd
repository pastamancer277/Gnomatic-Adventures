extends screen

@onready var reload_button = $VBoxContainer/Reload
@onready var restart_button = $VBoxContainer/Restart
var is_focus = null
# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/Global".pause = true
	await get_tree().process_frame
	isFocus = reload_button
	reload_button.grab_focus()

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("MoveDown") and (isFocus == reload_button):
			isFocus = restart_button
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("MoveDown") and (isFocus == restart_button):
			isFocus = reload_button
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("MoveUp") and (isFocus == restart_button):
			isFocus = reload_button
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("MoveUp") and (isFocus == reload_button):
			isFocus = restart_button
			isFocus.grab_focus()
			
			
	if Input.is_action_just_pressed("MeleeAttack") and (isFocus == reload_button):
		$/root/SaveManager.loadGame()
		$/root/Global.pause = false
		queue_free()
	elif Input.is_action_just_pressed("MeleeAttack") and (isFocus == restart_button):
		$/root/Global.resetGame()
		$/root/Global.pause = false
		queue_free()
