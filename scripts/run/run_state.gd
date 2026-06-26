extends Node
## RunState — single source of truth for the current run.
## Pure data: ids + primitives only, no nodes/Resources. The board renders from this.

signal material_changed(amount: int)
signal cores_changed(amount: int)
signal base_hp_changed(amount: int)

const SAVE_PATH := "user://run.save"

var current_run := false
var level := 1
var material := 0
var alien_cores := 0
var base_hp := 2000                  # placeholder starting hull
var base_hp_max := 2000
# each entry: { "def_id": String, "coords": [x, y], "level": int }
var placed_structures: Array = []    # untyped on purpose — JSON loads come back untyped

# --- lifecycle ---
func start_run() -> void:
	# TODO seed from MetaProgress
	current_run = true
	level = 1
	material = 10
	alien_cores = 0
	base_hp = 2000
	base_hp_max = base_hp
	placed_structures.clear()
	material_changed.emit(material)
	cores_changed.emit(alien_cores)
	base_hp_changed.emit(base_hp)

# --- material ---
func can_afford(cost: int) -> bool:
	return material >= cost

func add_material(amount: int) -> void:
	material += amount
	material_changed.emit(material)

func spend(cost: int) -> bool:
	if material < cost:
		return false
	material -= cost
	material_changed.emit(material)
	return true

# --- alien cores ---
func add_cores(amount: int) -> void:
	alien_cores += amount
	cores_changed.emit(alien_cores)

func spend_cores(cost: int) -> bool:
	if alien_cores < cost:
		return false
	alien_cores -= cost
	cores_changed.emit(alien_cores)
	return true

# --- base ---
func damage_base(amount: int) -> void:
	base_hp = max(base_hp - amount, 0)
	base_hp_changed.emit(base_hp)

# --- placed structures (the record; the board spawns the view) ---
func add_structure(def_id: String, coords: Vector2i) -> void:
	placed_structures.append({ "def_id": def_id, "coords": [coords.x, coords.y], "level": 0 })

func remove_structure(coords: Vector2i) -> void:
	for i in placed_structures.size():
		var c = placed_structures[i]["coords"]
		if int(c[0]) == coords.x and int(c[1]) == coords.y:
			placed_structures.remove_at(i)
			return

# --- serialization ---
func to_dict() -> Dictionary:
	return {
		"current_run": current_run,
		"level": level,
		"material": material,
		"alien_cores": alien_cores,
		"base_hp": base_hp,
		"base_hp_max": base_hp_max,
		"placed_structures": placed_structures,
	}

func from_dict(d: Dictionary) -> void:
	current_run = d.get("current_run", false)
	level = int(d.get("level", 1))        # JSON numbers parse as float — cast back
	material = int(d.get("material", 0))
	alien_cores = int(d.get("alien_cores", 0))
	base_hp = int(d.get("base_hp", 2000))
	base_hp_max = int(d.get("base_hp_max", 2000))
	placed_structures = d.get("placed_structures", [])

# --- disk I/O ---
func save_run() -> void:
	var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f:
		f.store_string(JSON.stringify(to_dict()))

func load_run() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	var data = JSON.parse_string(FileAccess.open(SAVE_PATH, FileAccess.READ).get_as_text())
	if typeof(data) != TYPE_DICTIONARY:
		return false
	from_dict(data)
	return true

func clear() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
