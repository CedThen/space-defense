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

#func _fire(target: Node2D) -> void:
	#if def.projectile_scene == null:
		#return
	#var p := def.projectile_scene.instantiate() as Projectile
	#get_tree().current_scene.add_child(p)
	#p.global_position = global_position
	#p.damage = def.damage
	#p.launch(target.global_position - global_position)

func _fire(target: Node2D) -> void:
	if def.projectile_scene == null:
		return
	var p := def.projectile_scene.instantiate() as Projectile
	get_tree().current_scene.add_child(p)
	p.global_position = global_position
	p.setup(target, def.damage)
