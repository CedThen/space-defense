@tool
class_name HexCell
extends Area2D

signal tapped(cell: HexCell)

const ART_RADIUS := 60.0   # the radius the visuals are authored at

@export var size := 60.0:
	set(value):
		size = value
		if is_node_ready():
			_apply()

var coords := Vector2i.ZERO
var occupant: Structure = null

func _ready() -> void:
	_apply()
	if not Engine.is_editor_hint():
		input_event.connect(_on_input_event)
		mouse_entered.connect(func(): set_hover_highlight(true))
		mouse_exited.connect(func(): set_hover_highlight(false))

func _apply() -> void:
	var art := get_node_or_null("Art") as Node2D
	var collision := get_node_or_null("CollisionPolygon2D") as CollisionPolygon2D
	if art == null or collision == null:
		return
	collision.polygon = _hex_points(size)
	art.scale = Vector2.ONE * (size / ART_RADIUS)

func _hex_points(r: float) -> PackedVector2Array:
	var pts := PackedVector2Array()
	for i in 6:
		var a := deg_to_rad(30 + 60.0 * i)   # flat-top
		pts.append(Vector2(cos(a), sin(a)) * r)
	return pts

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		tapped.emit(self)

func set_highlight(on: bool) -> void:
	$Art/Glow.visible = on

func set_hover_highlight(isHovered: bool) -> void:
	$Art/Sprite2D.modulate = Color(0.7, 1.3, 1.5) if isHovered else Color.WHITE
