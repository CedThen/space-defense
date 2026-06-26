extends CanvasLayer
## Routes hex taps to the build menu; forwards the choice to GameManager.

@onready var _grid: Node2D = %HexGrid
@onready var _game: GameManager = %GameManager
@onready var _build_menu: BuildMenu = %BuildMenu

var _current_cell: HexCell
var _dismissed_cell: HexCell   # cell the press just closed; its following tap is a toggle-off

func _ready() -> void:
	for child in _grid.get_children():
		var cell := child as HexCell
		if cell:
			cell.tapped.connect(_on_cell_tapped)
	_build_menu.defense_chosen.connect(_on_defense_chosen)
	_build_menu.close_requested.connect(_close_menu)

# Fires on a press BEFORE cell picking. Reset the memory each press; if the menu
# is open, close it now and note which cell it was on.
func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton and event.pressed):
		return
	_dismissed_cell = null
	if _build_menu.visible:
		_dismissed_cell = _current_cell
		_close_menu()

# Fires right after, via picking. The dismiss already ran, so we only decide
# whether to (re)open.
func _on_cell_tapped(cell: HexCell) -> void:
	if cell == _dismissed_cell:
		return                       # same cell that just closed → leave it shut (toggle)
	if cell.occupant != null:
		return                       # occupied → StructureCard later
	_select_cell(cell)
	_build_menu.open(_game.structure_defs)
	_position_menu_near(cell)

func _select_cell(cell: HexCell) -> void:
	if _current_cell != null:
		_current_cell.set_highlight(false)
	_current_cell = cell
	_current_cell.set_highlight(true)

func _on_defense_chosen(def: StructureDef) -> void:
	if _current_cell != null:
		_game.try_build(_current_cell, def)
	_close_menu()

func _close_menu() -> void:
	if _current_cell != null:
		_current_cell.set_highlight(false)
	_build_menu.hide()
	_current_cell = null

func _position_menu_near(cell: HexCell) -> void:
	var vp := get_viewport().get_visible_rect().size
	var xf := cell.get_global_transform_with_canvas()
	var anchor := xf.get_origin()
	var radius := cell.size * xf.get_scale().x
	var size := _build_menu.get_combined_minimum_size()
	var gap := radius + 8.0

	var extend_right := anchor.x < vp.x * 0.5
	var x := (anchor.x + gap) if extend_right else (anchor.x - gap - size.x)
	var y := anchor.y - gap - size.y

	x = clampf(x, 10.0, vp.x - size.x - 10.0)
	y = clampf(y, 10.0, vp.y - size.y - 10.0)
	_build_menu.global_position = Vector2(x, y)
