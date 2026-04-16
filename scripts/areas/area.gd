@abstract extends Node2D

class_name area

@onready var player = get_node("/root/Main/Sort/PlayerEntities/Player")

var active
var locationChange

func _process(delta: float) -> void:
	change_scene()

func change_scene():
	if(Global.scene_transit):
		if(Global.cur_area==name):
			Global.finish_scene_change(locationChange)
			visible=false

func set_active(is_active: bool) -> void:
	active=is_active
	visible = is_active
	set_all_tile_collisions(is_active)
	
	for collision in $Collisions.get_children():
		if collision is CollisionShape2D or collision is CollisionPolygon2D:
			collision.set_deferred("disabled", not is_active)
	for collision in $EnemyCollisions.get_children():
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

func enterFrom(node:String):
	for child in $EnterPoints.get_children():
		if(child.name==node):
			player.global_position=child.global_position

func getActive():
	return active
