extends Control

var help_screen = load("res://scenes/screens/help_screen.tscn")
var level_screen = load("res://scenes/screens/level_screen.tscn")
@onready var help_button: Button = $MarginContainer/VBoxContainer/HelpButton
@onready var level_button: Button = $MarginContainer/VBoxContainer/LevelButton
@onready var setting_button: Button = $MarginContainer/VBoxContainer/SettingButton
@onready var credit_button: Button = $MarginContainer/VBoxContainer/CreditButton
@onready var grid = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/VBoxContainer/Control2/Grid"
@onready var isFocus: Button = null
func _ready() -> void:
	isFocus = help_button
	if isFocus != null:
		isFocus.grab_focus() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !$/root/Global.pause:
		if Input.is_action_just_pressed("MoveDown") and (isFocus == help_button):
			isFocus = level_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveDown") and (isFocus == level_button):
			isFocus = setting_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveDown") and (isFocus == setting_button):
			isFocus = credit_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveDown") and (isFocus == credit_button):
			isFocus = help_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveUp") and (isFocus == credit_button):
			isFocus = setting_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveUp") and (isFocus == setting_button):
			isFocus = level_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveUp") and (isFocus == level_button):
			isFocus = help_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveUp") and (isFocus == help_button):
			isFocus = credit_button
			isFocus.grab_focus()
			
		if Input.is_action_just_pressed("ui_accept") and isFocus == help_button :
			var help = help_screen.instantiate()
			$/root/Main/UI/Screens.add_child(help)
			queue_free()
		if Input.is_action_just_pressed("ui_accept") and isFocus == level_button :
			var level = level_screen.instantiate()
			$/root/Main/UI/Screens.add_child(level)
			queue_free()
		
