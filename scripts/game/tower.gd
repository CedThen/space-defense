extends Node2D

@export var range: float = 120.0
@export var fire_rate: float = 1.0  # shots per second
@export var damage: float = 10.0
@export var projectile_scene: PackedScene

var _cooldown: float = 0.0
var _target: Node2D = null

func _process(delta: float) -> void:
	_cooldown -= delta
	_pick_target()
	if _target and _cooldown <= 0.0:
		_fire()
		_cooldown = 1.0 / fire_rate

func _pick_target() -> void:
	if is_instance_valid(_target) and position.distance_to(_target.position) <= range:
		return
	_target = null
	var closest_dist := range + 1.0
	for enemy in get_tree().get_nodes_in_group("enemies"):
		var d := position.distance_to(enemy.position)
		if d <= range and d < closest_dist:
			closest_dist = d
			_target = enemy

func _fire() -> void:
	if not projectile_scene:
		return
	var p := projectile_scene.instantiate()
	get_tree().current_scene.add_child(p)
	p.global_position = global_position
	p.setup(_target, damage)
