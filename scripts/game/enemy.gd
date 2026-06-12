extends CharacterBody2D

@export var speed: float = 80.0
@export var max_hp: float = 30.0

var hp: float

signal reached_bottom
signal died

func _ready() -> void:
	hp = max_hp

func _physics_process(delta: float) -> void:
	velocity = Vector2(0.0, speed)
	move_and_slide()
	if position.y > get_viewport_rect().size.y + 32.0:
		reached_bottom.emit()
		queue_free()

func take_damage(amount: float) -> void:
	hp -= amount
	if hp <= 0.0:
		died.emit()
		queue_free()
