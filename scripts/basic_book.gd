extends StaticBody2D

var player = null
var page = 0
var isOpen = false
var pages = null

func _ready() -> void:
	pages = $BookPages.get_children()
	$BookPages.visible=false

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Interact") and player!=null):
		if(isOpen):
			close()
		else:
			open()
	if(isOpen and Input.is_action_just_pressed("MoveRight") and page < pages.size()-1):
		page+=1
	if(isOpen and Input.is_action_just_pressed("MoveLeft") and page>0):
		page-=1
	
	setPage()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player=body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body == player):
		body=null

func open():
	page = 0
	isOpen = true
	$BookPages.visible = true
	$"/root/Global".pause = true

func close():
	isOpen = false
	$BookPages.visible = false
	$"/root/Global".pause = false

func setPage():
	for p in pages:
		p.visible=false
	pages.get(page).visible = true
