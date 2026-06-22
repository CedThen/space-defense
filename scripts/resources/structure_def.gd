class_name StructureDef
extends Resource

enum Category { WEAPON, ECONOMY, SUPPORT }

@export var display_name: String = ""
@export var category: Category = Category.WEAPON
@export var texture: Texture2D
@export var cost_material: int = 0
@export var attack_range: float = 120.0
@export var fire_rate: float = 1.0  # shots per second
@export var damage: float = 10.0
@export var projectile_scene: PackedScene
@export var projectile_speed: float = 400.0
