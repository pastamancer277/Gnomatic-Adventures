extends Control
var full_text = null
@onready var label = $MarginContainer/HBoxContainer/Label
func _ready() -> void:
	full_text = label.text
	label.text = ""
	label.text = _smart_wrap_text(full_text, get_viewport().size.x *.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _is_too_long()-> void:
	if full_text.length() < 35 or full_text[33] == " " or full_text[34] == " " or full_text[33] =="." or full_text[34] =="!" or full_text[34] =="." or full_text[34] =="!":
		label.text += full_text.substr(0,35)
		full_text = full_text.substr(35, full_text.length()-35)
	else:
		var index = 0
		for i in range(35):
			if full_text[i] == " ":
				index = i
		label.text += full_text.substr(0, index+1)
		full_text = full_text.substr(index+1, full_text.length()-(index+1))
	if full_text.length()>34:
		label.text += "\n"
		_is_too_long()
	else: 
		if full_text.length() == 1 and (full_text[0] =="." or full_text[0] =="!"or full_text[0] ==" ") :
			print("unnecessary")
		else: 
			label.text += full_text.left(full_text.length())
			
func _smart_wrap_text(input_text: String, max_pixel_width: float) -> String:
	var font = label.get_theme_font("font")
	var font_size = label.get_theme_font_size("font_size")
	var words = input_text.split(" ")
	var final_string = ""
	var current_line = ""

	for word in words:
		# Check how long the line would be if we added this word
		var test_line = current_line + word + " "
		var line_width = font.get_string_size(test_line, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
		
		if line_width > max_pixel_width:
			# Too long! Wrap the current line and start a new one with this word
			final_string += current_line.strip_edges() + "\n"
			current_line = word + " "
		else:
			current_line = test_line

	# Add the very last bit
	final_string += current_line.strip_edges()
	return final_string
