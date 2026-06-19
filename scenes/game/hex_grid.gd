@tool
extends Node2D

@export var hex_cell_scene: PackedScene
@export var hex_size := 60.0
@export var cols := 7          # cells in the LONG rows; short rows get cols - 1
@export var rows := 2
@export var margin := 0.0      # gap between cells (0 = touching)
@export var rebuild := false:
	set(value):
		rebuild = false
		_build()

func _ready() -> void:
	_build()

func _build() -> void:
	for child in get_children():
		child.queue_free()
	if hex_cell_scene == null:
		return
	var w := sqrt(3.0) * hex_size + margin     # horizontal step (pointy-top width + gap)
	var row_step := 1.5 * hex_size + margin    # vertical step between rows
	var x_center := (cols - 1) * w * 0.5
	var y_center := (rows - 1) * row_step * 0.5
	for row in rows:
		var short := row % 2 == 0               # even rows = short + indented
		var count := (cols - 1) if short else cols
		var x_off := (w * 0.5) if short else 0.0
		for col in count:
			var cell := hex_cell_scene.instantiate() as HexCell
			cell.size = hex_size
			add_child(cell)
			cell.position = Vector2(col * w + x_off - x_center, row * row_step - y_center)
			cell.coords = Vector2i(col, row)
