class_name EnemyDef
extends Resource

@export var display_name: String = ""
@export var texture: Texture2D
@export var display_scale: float = 1.0    # tweak to size the sprite on screen

@export var max_hp: float = 30.0
@export var speed: float = 90.0

@export var attack_damage: float = 5.0
@export var attack_rate: float = 1.0      # attacks per second
@export var attack_range: float = 80.0    # stops this far from the base, then attacks

@export var reward: int = 5               # material on death

# Later: race, resistances, behavior, projectile (ranged), render_mode (swarm/MultiMesh)
