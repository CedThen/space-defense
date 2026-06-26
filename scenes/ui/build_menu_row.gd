class_name BuildRow
extends Button
## One build option. setup() fills it from a StructureDef; emits chosen() on press.

signal chosen(def: StructureDef)

@onready var _icon: TextureRect = %Icon
@onready var _name: Label = %NameLabel
@onready var _cost: Label = %CostLabel

var _def: StructureDef

func _ready() -> void:
	pressed.connect(_on_pressed)

func setup(def: StructureDef) -> void:
	_def = def
	_name.text = def.display_name
	_cost.text = "%d" % def.cost_material
	if def.texture:
		_icon.texture = def.texture
	modulate.a = 1.0 if RunState.can_afford(def.cost_material) else 0.5

func _on_pressed() -> void:
	if RunState.can_afford(_def.cost_material):
		chosen.emit(_def)
