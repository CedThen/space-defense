class_name WaveSpawner
extends Node

## Spawns enemies on a timer when started. GameManager drives start()/stop().

@export var enemy_scene: PackedScene
@export var enemy_defs: Array[EnemyDef]    # one is picked at random per spawn
@export var enemies_container: Node2D      # the "Enemies" node in battle.tscn — keep it at (0,0)
@export var spawn_area: Area2D             # Area2D + RectangleShape2D marking the top band
@export var spawn_interval := 2.0

var _timer := 0.0
var _spawning := false

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
	if enemy_scene == null or enemies_container == null or spawn_area == null or enemy_defs.is_empty():
		return
	var e := enemy_scene.instantiate() as Enemy
	e.def = enemy_defs.pick_random()        # set def + position BEFORE add_child so _ready sees them
	e.position = _random_spawn_point()
	enemies_container.add_child(e)

func _random_spawn_point() -> Vector2:
	var shape := (spawn_area.get_node("CollisionShape2D") as CollisionShape2D).shape as RectangleShape2D
	var half_w := shape.size.x * 0.5
	var c := spawn_area.global_position
	return Vector2(c.x + randf_range(-half_w, half_w), c.y)
