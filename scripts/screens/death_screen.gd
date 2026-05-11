extends screen

@onready var reload_button = $VBoxContainer/Reload
@onready var restart_button = $VBoxContainer/Restart
@onready var label = $Label
@onready var global = $"/root/Global"
@onready var player = get_node("/root/Main/Sort/PlayerEntities/Player")
var is_focus = null
# Called when the node enters the scene tree for the first time.
var cleared = false

func _ready():
	$Timer.start()
	$"/root/Global".pause = true
	await get_tree().process_frame
	isFocus = reload_button
	reload_button.add_theme_constant_override("outline_size", 2)
	label.text = "NPCs killed: " + str(global.npcsKilled) + "\nQuests Completed: " + str(global.quests_complete) +"\nSocial Credit: " + str(player.socialCredit) +"\nLevel: " + str(player.level)

func _process(delta:float) -> void:
	if cleared:
		if Input.is_action_just_pressed("MoveDown") and (isFocus == reload_button):
				isFocus.add_theme_constant_override("outline_size", 0)
				isFocus = restart_button
				isFocus.add_theme_constant_override("outline_size", 2)
		elif Input.is_action_just_pressed("MoveDown") and (isFocus == restart_button):
				isFocus.add_theme_constant_override("outline_size", 0)
				isFocus = reload_button
				isFocus.add_theme_constant_override("outline_size", 2)
		elif Input.is_action_just_pressed("MoveUp") and (isFocus == restart_button):
				isFocus.add_theme_constant_override("outline_size", 0)
				isFocus = reload_button
				isFocus.add_theme_constant_override("outline_size", 2)
		elif Input.is_action_just_pressed("MoveUp") and (isFocus == reload_button):
				isFocus.add_theme_constant_override("outline_size", 0)
				isFocus = restart_button
				isFocus.add_theme_constant_override("outline_size", 2)
				
				
		if Input.is_action_just_pressed("MeleeAttack") and (isFocus == reload_button):
			$/root/SaveManager.loadGame()
			$/root/Global.pause = false
			queue_free()
		elif Input.is_action_just_pressed("MeleeAttack") and (isFocus == restart_button):
			$/root/Global.resetGame()
			$/root/Global.pause = false
			queue_free()


func _on_timer_timeout() -> void:
	cleared=true
