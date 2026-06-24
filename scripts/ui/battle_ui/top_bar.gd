extends PanelContainer
## TopBar HUD — resources (left), level (center), wave (right). View of RunState.

@onready var _material: Label = %MaterialLabel
@onready var _cores: Label = %CoresLabel
@onready var _level: Label = %LevelLabel
@onready var _wave: Label = %WaveLabel

func _ready() -> void:
	RunState.material_changed.connect(_on_material_changed)
	RunState.cores_changed.connect(_on_cores_changed)
	_on_material_changed(RunState.material)
	_on_cores_changed(RunState.alien_cores)
	_level.text = "Level %d" % RunState.level
	_wave.text = "Wave 1"   # placeholder until GameManager drives wave state

func _on_material_changed(amount: int) -> void:
	_material.text = "%d" % amount

func _on_cores_changed(amount: int) -> void:
	_cores.text = "%d" % amount
