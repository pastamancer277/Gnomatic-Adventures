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
	woodQuest=get_node("../Quests/WoodQuest3")
	person_name = "Betty"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/GrandmaGrandmaa.png").get_image()
	im = im.get_region(Rect2(im.get_width()/5,im.get_height()/7, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
			dialogueBox.dialogue("Hello dearie. Would you go find me some wood? I'm an old woman, I can't collect wood like I used to. I also know where you might be able to find a teddy bear, as I've heard you need.", self, person_name, tex)
			dialogueBox.setDialogueOption("Of course.", 0)
	else: if(run==2):
		dialogueBox.dialogue("Did you bring the wood?",self, person_name, tex)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if run ==3:
		dialogueBox.dialogue("Thank you so much! That teddy bear I mentioned? Her parent has been hanging around that cat in the forest, they'll know where she is.",self, person_name, tex)
		dialogueBox.setDialogueOption("You're welcome and thank you!", 0)

func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
			woodQuest.activate()
			quest_item = quest_item_scene.instantiate()
			item_slot = item_slot_scene.instantiate()
			item_slot.set_item(wood_item, 1)
			var items = [item_slot]
			quest_item.new_quest(items, "Chopped", "Betty needs wood and she can't get it herself")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
		else: if(key==1):
			pass
		
	else: if(run==2):
		if(key==0):
			woodQuest.tryComplete()
			if(woodQuest.isComplete()):
				run+=1
				quest_item.queue_free()
				interact()
		if(key==1):
			pass
	else: if(run==3):
		if(key==0):
			pass

func setQuest(name):
			quest_item = quest_item_scene.instantiate()
			item_slot = item_slot_scene.instantiate()
			item_slot.set_item(wood_item, 1)
			var items = [item_slot]
			quest_item.new_quest(items, "Chopped", "Betty needs wood and she can't get it herself")
			quest_menu = $"/root/Main/UI/QuestMenu"
			quest_menu.get_child(0).add_child(quest_item)
