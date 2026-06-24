class_name Enemy
extends Area2D

## Travels in a straight line toward the Base. Reads its EnemyDef.
## Stop-at-range / attack / suicide come next; for now it just moves and can die.

@export var def: EnemyDef

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _collision: CollisionShape2D = $CollisionShape2D

enum State { ADVANCE, ATTACK }

var hp: float
var _state := State.ADVANCE
var _velocity: Vector2
var _target_point: Vector2
var _base: Node
var _attack_cooldown := 0.0

signal died

func get_velocity() -> Vector2:
	return _velocity

func _ready() -> void:
	hp = def.max_hp
	if def.texture:
		_sprite.texture = def.texture
	_sprite.scale = Vector2.ONE * def.display_scale
	_size_collision_from_texture()
	_base = get_tree().get_first_node_in_group("base")
	_target_point = _pick_base_target()
	_velocity = (_target_point - global_position).normalized() * def.speed

func _physics_process(delta: float) -> void:
	match _state:
		State.ADVANCE: _advance(delta)
		State.ATTACK: _attack(delta)

func _advance(delta: float) -> void:
	global_position += _velocity * delta
	if _base != null and global_position.distance_to(_target_point) <= def.attack_range:
		if def.attack_kind == EnemyDef.AttackKind.SUICIDE:
			_hit_base()
			_die()
		else:
			_state = State.ATTACK
	elif not get_viewport_rect().has_point(global_position):
		queue_free()   # safety net if there's no base to stop at

func _attack(delta: float) -> void:
	_attack_cooldown -= delta
	if _attack_cooldown <= 0.0:
		_hit_base()
		_attack_cooldown = 1.0 / def.attack_rate

func _hit_base() -> void:
	if _base != null and _base.has_method("take_damage"):
		_base.take_damage(int(def.attack_damage))

func take_damage(amount: float) -> void:
	hp -= amount
	if hp <= 0.0:
		_die()

func _die() -> void:
	died.emit()
	queue_free()   # TODO: play def.anim_death once we have an AnimationPlayer

# Build a circle hitbox from the sprite size so we don't hand-set one per enemy.
# The Sprite2D is scaled by display_scale but this CollisionShape2D isn't, so apply it here.
func _size_collision_from_texture() -> void:
	if def.texture == null:
		return
	var tex := def.texture.get_size() * def.display_scale
	var circle := CircleShape2D.new()
	circle.radius = max(tex.x, tex.y) * 0.3
	_collision.shape = circle
	
	
# Pick a random x across the base's width, at its top edge, so enemies descend at varied angles.
# Pick a random x across the base's width, at its top edge, so enemies descend at varied angles.
func _pick_base_target() -> Vector2:
	var base := get_tree().get_first_node_in_group("base") as Node2D
	var poly := _base_polygon(base)
	if poly == null:
		return global_position + Vector2.DOWN   # fallback: straight down
	var xf := poly.global_transform
	var min_x := INF
	var max_x := -INF
	var top_y := INF
	for p in poly.polygon:
		var g: Vector2 = xf * p
		min_x = min(min_x, g.x)
		max_x = max(max_x, g.x)
		top_y = min(top_y, g.y)
	return Vector2(randf_range(min_x, max_x), top_y)

# Find the base's polygon by type, so its node name doesn't matter.
func _base_polygon(base: Node) -> CollisionPolygon2D:
	if base == null:
		return null
	for child in base.get_children():
		if child is CollisionPolygon2D:
			return child
	return null
