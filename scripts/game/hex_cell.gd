@tool
class_name HexCell
extends Area2D

const ART_RADIUS := 60.0   # the radius hex_cell.svg was drawn at (right vertex is 60px from center)

@export var size := 60.0:
	set(value):
		size = value
		if is_node_ready():
			_apply()

var coords := Vector2i.ZERO
var occupant: Node = null

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _collision: CollisionPolygon2D = $CollisionPolygon2D

func _ready() -> void:
	_apply()

func _apply() -> void:
	_collision.polygon = _hex_points(size)
	_sprite.scale = Vector2.ONE * (size / ART_RADIUS)   # scale art to match size

func _hex_points(r: float) -> PackedVector2Array:
	var pts := PackedVector2Array()
	for i in 6:
		var a := deg_to_rad(30 + 60.0 * i)   # flat-top
		pts.append(Vector2(cos(a), sin(a)) * r)
	return pts

func set_highlight(on: bool) -> void:
	_sprite.modulate = Color(1.4, 1.4, 1.4) if on else Color.WHITE
