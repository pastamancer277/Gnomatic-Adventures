extends screen

@onready var page_left = $BoxContainer/Page_Left
@onready var page_right = $BoxContainer/Page_Right

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MeleeAttack"):
		queue_free()
