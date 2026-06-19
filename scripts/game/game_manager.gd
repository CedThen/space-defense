extends Node

@export var base_hp: int = 20
@export var enemy_scene: PackedScene
@export var spawn_interval: float = 2.0

var _hp: int
var _spawn_timer: float = 0.0
var _viewport_size: Vector2

const DEFENSE_ART_RADIUS := 60.0   # defenses are drawn to a radius-60 hex, same as the tile

signal base_hp_changed(new_hp: int)
signal game_over

func _ready() -> void:
	_hp = base_hp
	_viewport_size = get_viewport().get_visible_rect().size

func _process(delta: float) -> void:
	_spawn_timer -= delta
	if _spawn_timer <= 0.0:
		_spawn_enemy()
		_spawn_timer = spawn_interval


func _spawn_enemy() -> void:
	if not enemy_scene:
		return
	var e := enemy_scene.instantiate()
	add_child(e)
	e.position = Vector2(randf_range(32.0, _viewport_size.x - 32.0), -32.0)
	e.add_to_group("enemies")
	e.reached_bottom.connect(_on_enemy_reached_bottom)

func _on_enemy_reached_bottom() -> void:
	_hp -= 1
	base_hp_changed.emit(_hp)
	if _hp <= 0:
		game_over.emit()
