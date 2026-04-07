extends Control

var help_screen = load("res://scenes/help_screen.tscn")
@onready var help_button: Button = $PanelContainer/MarginContainer/VBoxContainer/HelpButton
@onready var setting_button: Button = $PanelContainer/MarginContainer/VBoxContainer/SettingButton
@onready var credit_button: Button = $PanelContainer/MarginContainer/VBoxContainer/CreditButton
@onready var grid = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/VBoxContainer/Control2/Grid"
@onready var isFocus: Button = null
func _ready() -> void:
	isFocus = help_button
	if isFocus != null:
		isFocus.grab_focus() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !$/root/Global.pause:
		if Input.is_action_just_pressed("ui_down") and (isFocus == help_button):
			isFocus = setting_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("ui_down") and (isFocus == setting_button):
			isFocus = credit_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("ui_down") and (isFocus == credit_button):
			isFocus = help_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("ui_up") and (isFocus == credit_button):
			isFocus = setting_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("ui_up") and (isFocus == setting_button):
			isFocus = help_button
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("ui_up") and (isFocus == help_button):
			isFocus = credit_button
			isFocus.grab_focus()
			
		if Input.is_action_just_pressed("ui_accept") and isFocus == help_button :
			var help = help_screen.instantiate()
			help.set_script(load("res://scripts/help_screen.gd"))
			$/root/Main/UI/Screens.add_child(help)
			
			queue_free()
		


func _on_help_button_pressed() -> void:
	$/root/Main/UI/Screens/HelpScreen.visible = true


func _on_setting_button_pressed() -> void:
	pass # Replace with function body.


func _on_credit_button_pressed() -> void:
	pass # Replace with function body.
