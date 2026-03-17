extends Resource
class_name enemy_res

@export var maxHealth: int
@export var speed: int
@export var attackValue: int
@export var xpValue: int

@export var sightRadius: int
@export var attackRadius: float
@export var regenSpeed: float
@export var regenAmount: int
@export var attackCooldown: float
@export var respawnTime: float
@export var collisionRadius: float

@export var animations: SpriteFrames

@export var items: Array[item_drop]
