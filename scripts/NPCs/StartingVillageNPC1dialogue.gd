extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var wood_item: Item = preload("res://resources/items/Meat.tres")
@onready var quest_menu = $"../../../../../../../UI/HelpMenusInterface"/VBoxContainer/HBoxContainer/QuestMenu
@onready var quest_item_scene = load("res://scenes/quest_item.tscn")
@onready var item_slot_scene = load("res://scenes/item_slot.tscn")
var  item_slot = null
var quest_item = null
func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Lola"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/femalegnome3.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		if(player.getSocialCredit()>49 and !player.hasKeyword("catHasPie")):
			dialogueBox.dialogue("I need some meat can I buy some from you?", self,person_name, tex)
			dialogueBox.setDialogueOption("Yes of course!", 0)
			dialogueBox.setDialogueOption("I'mactualy arn't selling right now sorry.", 1)
		else:
			dialogueBox.dialogue("You talked to a Cat! Do they even like Pie!", self,person_name, tex)
			dialogueBox.setDialogueOption("They do actualy but I have to go!", 1)
	else: if (run == 2):
		dialogueBox.dialogue("Well, may I have it?", self,person_name, tex)
		dialogueBox.setDialogueOption("Here you go!", 0)
		dialogueBox.setDialogueOption("Eh, I don't think so.", 1)
	else: if(run==3):
		dialogueBox.dialogue("Are you sure that's Meat.",self,person_name, tex)
		dialogueBox.setDialogueOption("Ah, okay.", 0)
	else: if(run==4):
		dialogueBox.dialogue("Thank you! Here are 5 Gold!",self,person_name, tex)
		dialogueBox.setDialogueOption("Thank you for your buiseness", 0)
		dialogueBox.setDialogueOption("Bye", 0)
	else: if(run==5):
		dialogueBox.dialogue("Thanks again.",self,person_name, tex)
		dialogueBox.setDialogueOption("You're welcome!", 0)
		dialogueBox.setDialogueOption("Bye!", 0)

func playerResponse(key: int):
	if(run==1):
		if(key==0):
			get_node("../Quests/VillageMeatQuest").activate()
			quest_item = quest_item_scene.instantiate()
			item_slot = item_slot_scene.instantiate()
			item_slot.set_item(wood_item, 1)
			var items = [item_slot]
			quest_item.new_quest(items, "Meat for sale", "Bring Lola Meat")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
			run+=1
			if key == 1:
				interact()
	else: if(run==2):
		if(key==0):
			get_node("../Quests/VillageMeatQuest").tryComplete()
			if(get_node("../Quests/VillageMeatQuest").isComplete()):
				quest_item.queue_free()
				run=4
				interact()
			else:
				run=3
				interact()
		else: if(key==1):
			pass
	else: if run == 3:
		run-=1
		interact()
	else: if(run==4):
		run=5
	else: if(run==5):
		pass
