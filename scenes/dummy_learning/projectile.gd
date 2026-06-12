class_name Projectile
extends Area2D

@export var speed := 400.0
@export var damage := 10.0

var _velocity := Vector2.ZERO

func launch(direction: Vector2) -> void:
	_velocity = direction.normalized() * speed

func _physics_process(delta):
	position += _velocity * delta

func _on_body_entered(body):          # connect this from the Area2D's Signals panel
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
