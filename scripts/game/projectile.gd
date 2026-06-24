class_name Projectile
extends Area2D

## Dumb straight-line projectile: launched with a direction, damage, and speed.
## Flies until it overlaps any enemy or leaves the screen. No homing, no target.

var _velocity: Vector2
var _damage: float

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func launch(direction: Vector2, damage: float, speed: float) -> void:
	_velocity = direction.normalized() * speed
	_damage = damage
	rotation = _velocity.angle()   # face travel direction; drop if the sprite is round

func _physics_process(delta: float) -> void:
	global_position += _velocity * delta
	if not get_viewport_rect().has_point(global_position):
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies") and area.has_method("take_damage"):
		area.take_damage(_damage)
		queue_free()
