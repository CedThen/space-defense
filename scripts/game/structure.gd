class_name Structure
extends Node2D

## A placeable structure (weapon category for now). Stats come from its StructureDef.
## Scans the "enemies" group, fires at the nearest in range. Behavior will split by
## category (weapon/economy/support) into subclasses or components later.

@export var def: StructureDef

@onready var _sprite: Sprite2D = $Sprite2D

var _cooldown := 0.0

func _ready() -> void:
	if def and def.texture:
		_sprite.texture = def.texture

func _process(delta: float) -> void:
	if def == null:
		return
	_cooldown -= delta
	var target := _acquire_target()
	if target and _cooldown <= 0.0:
		_fire(target)
		_cooldown = 1.0 / def.fire_rate

func _acquire_target() -> Node2D:
	var nearest: Node2D = null
	var nearest_dist := def.attack_range
	for node in get_tree().get_nodes_in_group("enemies"):
		var enemy := node as Node2D
		if enemy == null:
			continue
		var d := global_position.distance_to(enemy.global_position)
		if d <= nearest_dist:
			nearest_dist = d
			nearest = enemy
	return nearest

func _fire(target: Node2D) -> void:
	if def.projectile_scene == null:
		return
	var p := def.projectile_scene.instantiate() as Projectile
	var parent := get_tree().get_first_node_in_group("projectiles")
	(parent if parent else get_tree().current_scene).add_child(p)
	p.global_position = global_position
	p.launch(_aim_at(target), def.damage, def.projectile_speed)

# First-order lead: aim where the target will be by the time the shot reaches it.
func _aim_at(target: Node2D) -> Vector2:
	var target_vel := Vector2.ZERO
	if target is Enemy:
		target_vel = (target as Enemy).get_velocity()
	var t := global_position.distance_to(target.global_position) / def.projectile_speed
	return (target.global_position + target_vel * t) - global_position
