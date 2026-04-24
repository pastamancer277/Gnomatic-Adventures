extends Control

var time_out = 126
@onready var label =$HBoxContainer/VBoxContainer/Label
var full_text = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = " "
	#set_text(label.text)

func set_text(text: String) -> void:
	full_text = text
	_is_too_long()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_out-= 1
	if(time_out <=0):
		queue_free()

func _is_too_long()-> void:
	if full_text.length() < 45 or full_text[43] == " " or full_text[44] == " " or full_text[43] =="." or full_text[43] =="!" or full_text[44] =="." or full_text[44] =="!":
		label.text += full_text.substr(0,45)
		print(full_text)
		full_text = full_text.substr(45, full_text.length()-45)
		print(full_text)
	else:
		var index = 0
		for i in range(45):
			if full_text[i] == " ":
				index = i
		label.text += full_text.substr(0, index+1)
		full_text = full_text.substr(index+1, full_text.length()-(index+1))
	if full_text.length()>44:
		print("recursion")
		label.text += "\n"
		_is_too_long()
	else: 
		if full_text.length() == 1 and (full_text[0] =="." or full_text[0] =="!"or full_text[0] ==" ") :
			print("unnecessary")
		else: 
			label.text += full_text.left(full_text.length())
		
