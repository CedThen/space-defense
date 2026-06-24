extends PanelContainer
## Bottom bar — base HP readout. View of RunState.

@onready var speed_control_button: Button = %SpeedControlButton
@onready var _base_label: Label = %BaseLabel
@onready var _base_bar: ProgressBar = %BaseBar
@onready var tech_tree_button: MenuButton = %TechTreeButton

func _ready() -> void:
	RunState.base_hp_changed.connect(_on_base_hp_changed)
	_base_bar.max_value = RunState.base_hp_max
	_on_base_hp_changed(RunState.base_hp)

func _on_base_hp_changed(amount: int) -> void:
	_base_label.text = "Base %d" % amount
	_base_bar.value = amount
