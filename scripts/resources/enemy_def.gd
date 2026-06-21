class_name EnemyDef
extends Resource

enum AttackKind { ATTACK, SUICIDE }   ## ATTACK: stop at range, hit repeatedly. SUICIDE: ram base, one hit, die.

@export var display_name: String = ""
@export var texture: Texture2D
@export var display_scale: float = 1.0    # tweak to size the sprite on screen
@export var max_hp: float = 30.0
@export var speed: float = 90.0
@export var reward: int = 5               # material on death

@export_group("Attack")
@export var attack_kind: AttackKind = AttackKind.ATTACK
@export var attack_damage: float = 5.0
@export var attack_rate: float = 1.0       # attacks per second
@export var attack_range: float = 80.0     # stops this far from the base, then attacks
@export var projectile_scene: PackedScene  # ranged ATTACK fires this; null = melee/suicide

@export_group("Animations")                # names the enemy's AnimationPlayer plays; blank = skip
@export var anim_attack: StringName = &""
@export var anim_hit: StringName = &""      # on taking damage
@export var anim_death: StringName = &""
