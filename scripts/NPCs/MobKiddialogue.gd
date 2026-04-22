extends dialogue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	person_name = "Oliver"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/LumberJack.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
