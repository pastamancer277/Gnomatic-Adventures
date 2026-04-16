extends screen
@onready var grid = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/VBoxContainer/Control2/Grid"
@onready var control = $"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/VBoxContainer/Control2"
@onready var attack = $VBoxContainer/HBoxContainer/ButtonContainer/AttackButton
@onready var shield = $VBoxContainer/HBoxContainer/ButtonContainer/ShieldButton
@onready var health = $VBoxContainer/HBoxContainer/ButtonContainer/HealthButton
@onready var return_button = $VBoxContainer/ReturnButton
@onready var attack_label = $VBoxContainer/HBoxContainer/LabelContainer/Attack
@onready var shield_label =$VBoxContainer/HBoxContainer/LabelContainer/Shield
@onready var health_label = $VBoxContainer/HBoxContainer/LabelContainer/Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isFocus = attack
	if isFocus != null:
		isFocus.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down") and (isFocus == attack):
			isFocus = shield
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("ui_down") and (isFocus == shield):
			isFocus = health
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("ui_down") and (isFocus == health):
			isFocus = return_button
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("ui_down") and (isFocus == return_button):
			isFocus = attack
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("ui_up") and (isFocus == return_button):
			isFocus = health
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("ui_up") and (isFocus == health):
			isFocus = shield
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("ui_up") and (isFocus == shield):
			isFocus = attack
			isFocus.grab_focus()
	elif Input.is_action_just_pressed("ui_up") and (isFocus == attack):
			isFocus = return_button
			isFocus.grab_focus()
	attack_label.text = "Attack: " + str($/root/Main/Sort/PlayerEntities/Player.attack_value)
	shield_label.text = "Shield:" + str($/root/Main/Sort/PlayerEntities/Player.shield)
	health_label.text = "Max Health:" + str($/root/Main/Sort/PlayerEntities/Player.mHealth)


func _on_return_button_pressed() -> void:
	grid.change_clicked()
	grid.visible = true
	control.reset_count()
	$"/root/Global".pause = false;
	queue_free()


func _on_attack_button_pressed() -> void:
	$/root/Main/Sort/PlayerEntities/Player.levelAttack()


func _on_shield_button_pressed() -> void:
	$/root/Main/Sort/PlayerEntities/Player.levelShield() 

func _on_health_button_pressed() -> void:
	$/root/Main/Sort/PlayerEntities/Player.levelHealth()
