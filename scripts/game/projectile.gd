class_name Projectile
extends Node2D

## Homes on a target enemy until it hits or the target is gone.
## Straight-line / AoE variants come later (that version would be an Area2D).

@export var speed: float = 400.0

var _target: Node2D
var _damage: float

func setup(target: Node2D, damage: float) -> void:
	_target = target
	_damage = damage

func _process(delta: float) -> void:
	if not is_instance_valid(_target):
		queue_free()
		return
	var dir := (_target.global_position - global_position).normalized()
	global_position += dir * speed * delta
	if global_position.distance_to(_target.global_position) < 8.0:
		if _target.has_method("take_damage"):
			_target.take_damage(_damage)
		queue_free()
