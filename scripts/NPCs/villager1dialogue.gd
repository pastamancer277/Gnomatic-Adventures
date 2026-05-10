extends dialogue

var furQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var quest_menu = $"../../../../../../../UI/HelpMenusInterface"/VBoxContainer/HBoxContainer/QuestMenu
@onready var fur_item: Item = preload("res://resources/items/Fur.tres")
@onready var quest_item_scene = load("res://scenes/quest_item.tscn")
@onready var item_slot_scene = load("res://scenes/item_slot.tscn")
var  item_slot = null
var quest_item = null
func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	furQuest=get_node("../Quests/FurQuest")
	person_name = "Glory"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/NPC1.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
	
			dialogueBox.dialogue("Oh nooo, oh no no no!", self,person_name, tex)
			dialogueBox.setDialogueOption("Hello, what's troubling you?", 0)
			dialogueBox.setDialogueOption("...Bye", 1)
		
	else: if(run==2):
		dialogueBox.dialogue("I need to get fur to make a blanket, but the fur trader is missing! Can you get me fur?",self,person_name, tex)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose", 1)
		dialogueBox.setDialogueOption("No, I'm busy", 2)
	else: if(run==3):
		dialogueBox.dialogue("Did you bring the fur?",self,person_name, tex)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if(run==4):
		run = 5
	else: if run == 5:
		dialogueBox.dialogue("Thank you so much! Now I can make my blanket!",self,person_name, tex)
		dialogueBox.setDialogueOption("You're welcome!", 0)

func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
			interact()
		else: if(key==1):
			pass
		
	else: if(run==2):
		if(key==0 or key==1):
			run+=1
			furQuest.activate()
			quest_item = quest_item_scene.instantiate()
			item_slot = item_slot_scene.instantiate()
			item_slot.set_item(fur_item, 6)
			var items = [item_slot]
			quest_item.new_quest(items, "Bundled Up!", "Bring Glory fur for her blanket")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
		if(key==2):
			pass
	else: if(run==3):
		if(key==0):
			furQuest.tryComplete()
			if(furQuest.isComplete()):
				quest_item.queue_free()
				run+=1
				interact()
		if(key==1):
			pass
	else: if(run==4):
		if(key==0):
			pass

func setQuest(name):
			quest_item = quest_item_scene.instantiate()
			item_slot = item_slot_scene.instantiate()
			item_slot.set_item(fur_item, 6)
			var items = [item_slot]
			quest_item.new_quest(items, "Bundled Up!", "Bring Glory fur for her blanket")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
