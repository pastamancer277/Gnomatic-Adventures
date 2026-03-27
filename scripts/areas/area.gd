@abstract extends Node2D

class_name area

var active

func _process(delta: float) -> void:
	change_scene()

@abstract func change_scene()

func set_active(is_active: bool) -> void:
	active=is_active
	visible = is_active
	set_all_tile_collisions(is_active)
	
	for collision in $Collisions.get_children():
		if collision is CollisionShape2D or collision is CollisionPolygon2D:
			collision.set_deferred("disabled", not is_active)
	
	for entity in $Entities.get_children():
		entity.visible = is_active
		if is_active:
			entity.process_mode = PROCESS_MODE_INHERIT
		else:
			entity.process_mode = PROCESS_MODE_DISABLED

func set_all_tile_collisions(active: bool) -> void:
	for layer in $TileMap.get_children():
		if layer is TileMapLayer:
			layer.collision_enabled = active
			layer.visible=active

func getActive():
	return active
