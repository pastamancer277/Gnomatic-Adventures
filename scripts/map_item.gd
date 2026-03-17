extends Node2D

var item

func setup(i: Item):
	item=i
	$Sprite2D.texture = item.icon
	var newShape = CircleShape2D.new()
	newShape.radius = item.collectRadius
	$Area2D/CollisionShape2D.shape = newShape
	$Sprite2D.position.x=item.positionX
	$Sprite2D.position.y=item.positionY

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name=="Player":
		var inventory = get_node("/root/Main/Systems/Inventory")
		if inventory.add_item({item:1}):
			queue_free()

func setPosition(pos: Vector2, dist: float):
	global_position.x=pos.x+randi_range(0-dist,dist)
	global_position.y=pos.y+randi_range(0-dist, dist)
