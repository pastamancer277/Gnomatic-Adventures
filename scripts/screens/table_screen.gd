extends Control

var seen = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MeleeAttack") and seen:
		print("table1")
		queue_free()
		print("table")
		$"../CutScene".seen = true
