extends Node

@export var structure_scene: PackedScene
@export var structure_defs: Array[StructureDef]   # railgun.tres, flak_cannon.tres, ...

@onready var hex_grid: Node2D = %HexGrid
@onready var structures: Node2D = %Structures
@onready var wave_spawner: WaveSpawner = %WaveSpawner

const DEFENSE_ART_RADIUS := 60.0   # defenses are drawn to a radius-60 hex, same as the tile

func _ready() -> void:
	RunState.start_run()
	_prototype_populate()
	wave_spawner.start()
	
func place_structure(cell: HexCell, def: StructureDef) -> void:
	if cell.occupant != null or structure_scene == null:
		return
	RunState.add_structure(def.resource_path, cell.coords)
	_spawn_structure(cell, def)

func _spawn_structure(cell: HexCell, def: StructureDef) -> void:
	var s := structure_scene.instantiate() as Structure
	s.def = def
	structures.add_child(s)
	s.global_position = cell.global_position
	s.scale = Vector2.ONE * (cell.size / DEFENSE_ART_RADIUS)
	cell.occupant = s

func _prototype_populate() -> void:
	if structure_defs.is_empty():
		return
	for child in hex_grid.get_children():
		var cell := child as HexCell
		if cell and cell.coords.x % 3 == 0:
			place_structure(cell, structure_defs[cell.coords.x % structure_defs.size()])
