extends dialogue

var blueberryQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var quest_menu = $"../../../../../../../UI/HelpMenusInterface"/VBoxContainer/HBoxContainer/QuestMenu
@onready var blueberry_item: Item = preload("res://resources/items/Bluebeary.tres")
@onready var quest_item_scene = load("res://scenes/quest_item.tscn")
@onready var item_slot_scene = load("res://scenes/item_slot.tscn")
var  item_slot = null
var quest_item = null
func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	blueberryQuest=get_node("../Quests/BlueberryQuest")
	person_name = "Sienna"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/Kid2.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_width()/10, im.get_width()/2, im.get_height()/1.7))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(player.hasKeyword("orange_cat")):
		pass
	if(run==1):
		dialogueBox.dialogue("Hi, can you help me?!", self,person_name, tex)
		dialogueBox.setDialogueOption("Hi, of course I can help.", 0)
		dialogueBox.setDialogueOption("No kid, I have better things to do.", 1)
	else: if(run==2):
		dialogueBox.dialogue("I realllllly want some blueberry pie, but I don't know where the bushes are *cries*",self,person_name, tex)
		dialogueBox.setDialogueOption("Oh no", 0)
		dialogueBox.setDialogueOption("Are you okay?", 1)
		dialogueBox.setDialogueOption("Skill issue?", 2)
	else: if(run==3):
		dialogueBox.dialogue("Can you find some blueberries for me? I'll even give you my teddy bear!",self,person_name, tex)
		dialogueBox.setDialogueOption("Yes of course!", 0)
		dialogueBox.setDialogueOption("Oh, could you just give me the bear?", 1)
		dialogueBox.setDialogueOption("I don't know where they are either", 2)
	else: if(run==4):
		dialogueBox.dialogue("Have you found them yet!",self,person_name, tex)
		dialogueBox.setDialogueOption("Yes! Here they are.", 0)
		dialogueBox.setDialogueOption("I'm sorry, not yet.", 1)
	else: if run == 5:
		dialogueBox.dialogue("Thank you so much! Enjoy my teddy!",self,person_name, tex)
		dialogueBox.setDialogueOption("I will! Thank you!", 0)
		dialogueBox.setDialogueOption("You're welcome.", 1)
	else: if(run ==6):
		dialogueBox.dialogue("Umm... no?",self,person_name, tex)
		dialogueBox.setDialogueOption("...", 0)
		dialogueBox.setDialogueOption("Rude", 1)
	else: if run == 7:
		dialogueBox.dialogue("Oh well actually my teddy says she really wants to go with you! That never happens! She's normally sooooo shy, but since she likes you, you must be who she wants, so here you go! I'll find someone else to get me blueberries, I guess, and I have other teddies so I won't be lonely either! Thank you stranger, take care of my teddy.",self,person_name, tex)
		dialogueBox.setDialogueOption("I will! Thank you!", 0)
		dialogueBox.setDialogueOption("Thank you so much", 1)
		dialogueBox.setDialogueOption("Obviously she likes me, I'm great", 1)

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
			interact()
		if(key==2):
			pass
	else: if(run==3):
		if(key == 0):
			blueberryQuest.activate()
			quest_item = quest_item_scene.instantiate()
			item_slot = item_slot_scene.instantiate()
			item_slot.set_item(blueberry_item, 5)
			var items = [item_slot]
			quest_item.new_quest(items, "Berry Teddy Bear", "Bring Sienna blueberries and gain her teddy")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
			run+=1
		elif(key == 1):
			if player.getSocialCredit()>65:
				run =7
			else:
				run = 6
		interact()
	else: if(run==4):
		if(key==0):
			blueberryQuest.tryComplete()
			if(blueberryQuest.isComplete()):
				quest_item.queue_free()
				run+=1
				interact()
		if(key==1):
			pass
	else: if (run == 5):
		pass
	else: if (run == 6):
		run = 3
		interact()
	else: if(run==7):
		run = 1

func setQuest(name):
			quest_item = quest_item_scene.instantiate()
			item_slot = item_slot_scene.instantiate()
			item_slot.set_item(blueberry_item, 5)
			var items = [item_slot]
			quest_item.new_quest(items, "Berry Teddy Bear", "Bring Sienna blueberries and gain her teddy")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
