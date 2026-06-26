class_name BuildMenu
extends PanelContainer
## Side-docked build card. Instances a BuildRow per buildable structure.

signal defense_chosen(def: StructureDef)
signal close_requested

@export var row_scene: PackedScene   # BuildRow.tscn

@onready var _list: VBoxContainer = %BuildList
@onready var _close_button: Button = %CloseButton

func _ready() -> void:
	_close_button.pressed.connect(func(): close_requested.emit())
	hide()

func open(defs: Array) -> void:
	for c in _list.get_children():
		_list.remove_child(c)        # detach now so it no longer counts toward size…
		c.queue_free()               # …then free it safely
	for def in defs:
		var row := row_scene.instantiate() as BuildRow
		_list.add_child(row)
		row.setup(def as StructureDef)
		row.chosen.connect(_on_choose)
	show()

func _on_choose(def: StructureDef) -> void:
	defense_chosen.emit(def)
