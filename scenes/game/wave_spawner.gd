class_name WaveSpawner
extends Node

## Spawns enemies on a timer when started. GameManager drives start()/stop().

@export var enemy_scene: PackedScene
@export var spawn_interval := 2.0
@export var enemies_container: Node2D       # the "Enemies" node in battle.tscn

var _timer := 0.0
var _spawning := false
var _viewport_w := 0.0

func _ready() -> void:
	_viewport_w = get_viewport().get_visible_rect().size.x

func start() -> void:
	_spawning = true
	_timer = 0.0

func stop() -> void:
	_spawning = false

func _process(delta: float) -> void:
	if not _spawning:
		return
	_timer -= delta
	if _timer <= 0.0:
		_spawn_one()
		_timer = spawn_interval

func _spawn_one() -> void:
	if enemy_scene == null or enemies_container == null:
		return
	var e := enemy_scene.instantiate()
	enemies_container.add_child(e)
	e.global_position = Vector2(randf_range(32.0, _viewport_w - 32.0), -32.0)
	e.add_to_group("enemies")
