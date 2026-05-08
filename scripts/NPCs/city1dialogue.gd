extends dialogue

var woodQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var wood_item: Item = preload("res://resources/items/Wood.tres")
@onready var quest_menu = $"../../../../../../../UI/HelpMenusInterface"/VBoxContainer/HBoxContainer/QuestMenu
@onready var quest_item_scene = load("res://scenes/quest_item.tscn")
@onready var item_slot_scene = load("res://scenes/item_slot.tscn")
var  item_slot = null
var quest_item = null
func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	woodQuest=get_node("../Quests/WoodQuest")
	person_name = "Juliet"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/gnome2.png").get_image()
	im = im.get_region(Rect2(im.get_width()/5,im.get_height()/7, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
			dialogueBox.dialogue("Hey, village kid", self, person_name, tex)
			dialogueBox.setDialogueOption("Are you talking to me?", 0)
			dialogueBox.setDialogueOption("I'm not a village kid jerk!", 1)
		
	else: if(run==2):
		dialogueBox.dialogue("Yes you. I need wood to make a shelf. Can you get me wood?",self, person_name, tex)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose", 1)
		dialogueBox.setDialogueOption("No, I'm busy", 2)
	else: if(run==3):
		dialogueBox.dialogue("Did you bring the wood?",self, person_name, tex)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if run ==4:
		dialogueBox.dialogue("Thanks",self)
		dialogueBox.setDialogueOption("You're welcome", 0, person_name, tex)

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
			woodQuest.activate()
			quest_item = quest_item_scene.instantiate()
			item_slot = item_slot_scene.instantiate()
			item_slot.set_item(wood_item, 1)
			var items = [item_slot]
			quest_item.new_quest(items, "Wood's up?", "Bring Juliet wood for her shelf")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
		if(key==2):
			pass
	else: if(run==3):
		if(key==0):
			woodQuest.tryComplete()
			if(woodQuest.isComplete()):
				run+=1
				quest_item.queue_free()
				interact()
				$/root/Main/Systems/Inventory.add_item({gold:3})
		if(key==1):
			pass
	else: if(run==4):
		if(key==0):
			pass
