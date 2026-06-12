extends CharacterBody2D

@export var speed := 2.0
@export var projectile_scene: PackedScene
@export var target: Node2D

@onready var projectile_parent: Node2D = %ProjectileParent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready")

func fire(target: Node2D) -> void:
	var p := projectile_scene.instantiate() as Projectile
	projectile_parent.add_child(p)
	p.global_position = global_position
	var direction = Vector2(0, -1)
	p.launch(direction)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#position += Vector2(0, -speed) * delta
	velocity = Vector2(-speed, -speed)
	move_and_slide()

func _process(delta: float) -> void:
	if target:
		fire(target)
