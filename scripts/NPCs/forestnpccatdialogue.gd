extends dialogue

var woodQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var coin_item: Item = preload("res://resources/items/Gold.tres")
@onready var meat_item: Item = preload("res://resources/items/Meat.tres")
@onready var quest_menu = $"../../../../../../../UI/HelpMenusInterface"/VBoxContainer/HBoxContainer/QuestMenu
@onready var quest_item_scene = load("res://scenes/quest_item.tscn")
@onready var item_slot_scene = load("res://scenes/item_slot.tscn")
var  item_slot1 = null
var  item_slot2 = null
var quest_item = null
func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	woodQuest=get_node("../Quests/SpencerQuest")
	person_name = "Spencer"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/Spencer.png").get_image()
	im = im.get_region(Rect2(im.get_width()/5,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
			dialogueBox.dialogue("Hey kid! I happen to know where you can get a teddy bear? That interest you?", self, person_name, tex)
			dialogueBox.setDialogueOption("That does...", 0)
			dialogueBox.setDialogueOption("Why would I want a teddy bear?", 1)
		
	else: if(run==2):
		dialogueBox.dialogue("Good. My daughter happens to have quite a few, but I ain't tell you where she is until you prove yourself.",self, person_name, tex)
		dialogueBox.setDialogueOption("Of course, sir", 0)
		dialogueBox.setDialogueOption("Makes sense.", 1)
		dialogueBox.setDialogueOption("I've already killed a cat, what more do you want!", 2)
	else: if(run==3):
		dialogueBox.dialogue("I need some coins and meat to get me and my family through the next few days. You can handle that?",self, person_name, tex)
		dialogueBox.setDialogueOption("Sure, of course!", 0)
		dialogueBox.setDialogueOption("Not worth my effort, bud", 1)
	else: if run ==4:
		dialogueBox.dialogue("Have you brought them yet?",self, person_name, tex)
		dialogueBox.setDialogueOption("Yes, here they are.", 0)
		dialogueBox.setDialogueOption("No, sorry, sir", 1)
	else: if run ==5:
		dialogueBox.dialogue("Thank you so much. You don't know how much this means to my family. My daughter is visiting her grandmother in the first gnome village. She loves to move around so much...",self, person_name, tex)
		dialogueBox.setDialogueOption("Of course. Thank you so much sir.", 0)
		dialogueBox.setDialogueOption("You're welcome", 1)


func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
			interact()
		else: if(key==1):
			pass
	else: if(run==2):
		run+=1
		interact()
	else: if(run==3):
		if(key==0):
			woodQuest.activate()
			quest_item = quest_item_scene.instantiate()
			item_slot1 = item_slot_scene.instantiate()
			item_slot1.set_item(coin_item, 3)
			item_slot2 = item_slot_scene.instantiate()
			item_slot2.set_item(meat_item, 2)
			var items = [item_slot1, item_slot2]
			quest_item.new_quest(items, "Family Man", "Spencer needs money and meat for his family")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
			run+=1
		if(key==1):
			pass
	else: if(run==4):
		if(key==0):
			woodQuest.tryComplete()
			if(woodQuest.isComplete()):
				run+=1
				quest_item.queue_free()
				interact()
	else: if run ==5:
		pass

func setQuest(name):
			quest_item = quest_item_scene.instantiate()
			item_slot1 = item_slot_scene.instantiate()
			item_slot1.set_item(coin_item, 3)
			item_slot2 = item_slot_scene.instantiate()
			item_slot2.set_item(meat_item, 2)
			var items = [item_slot1, item_slot2]
			quest_item.new_quest(items, "Family Man", "Spencer needs money and meat for his family")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
