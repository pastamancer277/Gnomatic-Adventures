extends dialogue

var slimeQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var slimeball_item: Item = preload("res://resources/items/Fur.tres")
@onready var quest_menu = $"../../../../../../../UI/HelpMenusInterface"/VBoxContainer/HBoxContainer/QuestMenu
@onready var quest_item_scene = load("res://scenes/quest_item.tscn")
@onready var item_slot_scene = load("res://scenes/item_slot.tscn")
var  item_slot = null
var quest_item = null

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	slimeQuest=get_node("../Quests/SlimeQuest")
	person_name = "Fred"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/NPC1.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		if(player.getSocialCredit()>50):
			dialogueBox.dialogue("Hello there", self, person_name, tex)
			dialogueBox.setDialogueOption("Hi", 0)
			dialogueBox.setDialogueOption("Ugh, people", 1)
		else:
			dialogueBox.dialogue("I don't know you. Come back when you're more popular.", self,person_name, tex)
			dialogueBox.setDialogueOption("...", 2)
	else: if(run==2):
		dialogueBox.dialogue("Can you kill those animals and bring me the fur?",self ,person_name, tex)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose.", 1)
		dialogueBox.setDialogueOption("No, I'm busy.", 2)
	else: if(run==3):
		dialogueBox.dialogue("Have you killed the animals?",self,person_name, tex)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if run ==4:
		run = 5
	else: if(run==5):
		dialogueBox.dialogue("Thank you so much!",self,person_name, tex)
		dialogueBox.setDialogueOption("You're welcome.", 0)

func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
			interact()
		else: if(key==1):
			pass
		else:
			pass
	else: if(run==2):
		if(key==0 or key==1):
			run+=1
			slimeQuest.activate()
			quest_item = quest_item_scene.instantiate()
			item_slot = item_slot_scene.instantiate()
			item_slot.set_item(slimeball_item, 6)
			var items = [item_slot]
			quest_item.new_quest(items, "Furry Monsters", "Bring Fred the animals hides")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
			interact()
		if(key==2):
			pass
	else: if(run==3):
		if(key==0):
			slimeQuest.tryComplete()
			if(slimeQuest.isComplete()):
				run+=1
				interact()
				quest_item.queue_free()
				var popup_scene = load("res://scenes/popups.tscn").instantiate()
				$"/root/Main/UI/Popups".add_child(popup_scene)
				popup_scene.set_text("You gained a key! There must be a chest somewhere...")
				$/root/Global.multiple_popups()
		if(key==1):
			pass
	else: if(run==5):
		if(key==0):
			pass
