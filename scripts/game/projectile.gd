extends Node2D

var _target: Node2D
var _damage: float
var _speed: float = 400.0

func setup(target: Node2D, damage: float) -> void:
	_target = target
	_damage = damage

func _process(delta: float) -> void:
	if not is_instance_valid(_target):
		queue_free()
		return
	var dir := (_target.global_position - global_position).normalized()
	global_position += dir * _speed * delta
	if global_position.distance_to(_target.global_position) < 8.0:
		_target.take_damage(_damage)
		queue_free()
