extends Control

class_name screen

@onready var isFocus = $Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isFocus = $Button
	isFocus.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_button_pressed() -> void:
	print("hello")
	print(isFocus)
	queue_free() 
	print(isFocus)
	print("hello")
	$/root/Main/UI/Screens/InstructionScreen.is_focus.grab_focus() # Replace with function body.
