extends screen

var seen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MeleeAttack") and seen:
		queue_free()
		if $/root/Main/UI/Screens/InstructionScreen.is_focus!= null:
			$/root/Main/UI/Screens/InstructionScreen.is_focus.grab_focus()
