extends Control

@onready var isFocus: Button = null

@onready var help_menu = $VBoxContainer/HBoxContainer/VBoxContainer/HelpMenu
@onready var help_button: Button = $VBoxContainer/HBoxContainer/VBoxContainer/HelpMenu/MarginContainer/VBoxContainer/HelpButton
@onready var level_button: Button = $VBoxContainer/HBoxContainer/VBoxContainer/HelpMenu/MarginContainer/VBoxContainer/LevelButton
@onready var setting_button: Button = $VBoxContainer/HBoxContainer/VBoxContainer/HelpMenu/MarginContainer/VBoxContainer/SettingButton
@onready var credit_button: Button = $VBoxContainer/HBoxContainer/VBoxContainer/HelpMenu/MarginContainer/VBoxContainer/CreditButton

@onready var help_screen = $VBoxContainer/HBoxContainer/HelpScreen
@onready var credit_screen = $VBoxContainer/HBoxContainer/CreditScreen
@onready var setting_screen = $VBoxContainer/HBoxContainer/SettingScreen

@onready var level_screen = $VBoxContainer/HBoxContainer/LevelScreen
@onready var attack = $VBoxContainer/HBoxContainer/LevelScreen/MarginContainer/VBoxContainer/HBoxContainer/ButtonContainer/AttackButton
@onready var shield = $VBoxContainer/HBoxContainer/LevelScreen/MarginContainer/VBoxContainer/HBoxContainer/ButtonContainer/ShieldButton
@onready var health = $VBoxContainer/HBoxContainer/LevelScreen/MarginContainer/VBoxContainer/HBoxContainer/ButtonContainer/HealthButton
@onready var attack_label = $VBoxContainer/HBoxContainer/LevelScreen/MarginContainer/VBoxContainer/HBoxContainer/LabelContainer/Attack
@onready var shield_label =$VBoxContainer/HBoxContainer/LevelScreen/MarginContainer/VBoxContainer/HBoxContainer/LabelContainer/Shield
@onready var health_label = $VBoxContainer/HBoxContainer/LevelScreen/MarginContainer/VBoxContainer/HBoxContainer/LabelContainer/Health


@onready var inventory = $"../UI Interface"

func _ready() -> void:
	isFocus = help_button


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Help Menu visible
	if Input.is_action_just_pressed("Help_Menu") and $/root/Global.pause:
		help_menu. visible = false
		visible = false
		help_screen.visible = false
		level_screen.visible = false
		credit_screen.visible = false
		setting_screen.visible = false
		inventory.visible = true
		$"/root/Global".pause = false
		isFocus = help_button
	elif Input.is_action_just_pressed("Help_Menu") and !$/root/Global.pause:
		help_menu. visible = true
		visible = true
		help_screen.visible = true
		inventory.visible = false
		$"/root/Global".pause = true
	
	#Help Menu Button movement
	if visible:
		isFocus.grab_focus()
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
		
		
		#Level Screen Buttom Movement
		if Input.is_action_just_pressed("MoveDown") and (isFocus == attack):
			isFocus = shield
			isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveDown") and (isFocus == shield):
				isFocus = health
				isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveDown") and (isFocus == health):
				isFocus = attack
				isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveUp") and (isFocus == health):
				isFocus = shield
				isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveUp") and (isFocus == shield):
				isFocus = attack
				isFocus.grab_focus()
		elif Input.is_action_just_pressed("MoveUp") and (isFocus == attack):
				isFocus = health
				isFocus.grab_focus()
		attack_label.text = "Attack: " + str($/root/Main/Sort/PlayerEntities/Player.attack_value)
		shield_label.text = "Shield:" + str($/root/Main/Sort/PlayerEntities/Player.shield)
		health_label.text = "Max Health:" + str($/root/Main/Sort/PlayerEntities/Player.mHealth)
		
		
		#Level Screen Functionality
		if Input.is_action_just_pressed("MeleeAttack") and isFocus == attack:
			$/root/Main/Sort/PlayerEntities/Player.levelAttack()
		elif Input.is_action_just_pressed("MeleeAttack") and isFocus == shield:
			$/root/Main/Sort/PlayerEntities/Player.levelShield()
		elif Input.is_action_just_pressed("MeleeAttack") and isFocus == health:
			$/root/Main/Sort/PlayerEntities/Player.levelHealth()
		
		
		# Focusing on level screen buttons
		if isFocus == level_button:
			if Input.is_action_just_pressed("MoveLeft"):
				isFocus = attack
				isFocus.grab_focus()
			elif Input.is_action_just_pressed("MoveRight"):
				isFocus = attack
				isFocus.grab_focus()
		elif isFocus == attack or isFocus == shield or isFocus == health:
			if Input.is_action_just_pressed("MoveRight"):
				isFocus = level_button
				isFocus.grab_focus()
			elif Input.is_action_just_pressed("MoveLeft"):
				isFocus = level_button
				isFocus.grab_focus()
		
		
		#Visibility of "screens"
		if isFocus == help_button :
			help_screen.visible = true
			level_screen.visible = false
			credit_screen.visible = false
			setting_screen.visible = false
		elif  isFocus == level_button :
			level_screen.visible = true
			help_screen.visible = false
			credit_screen.visible = false
			setting_screen.visible = false
		elif  isFocus == setting_button :
			level_screen.visible = false
			help_screen.visible = false
			credit_screen.visible = false
			setting_screen.visible = true
		elif  isFocus == credit_button :
			level_screen.visible = false
			help_screen.visible = false
			credit_screen.visible = true
			setting_screen.visible = false
