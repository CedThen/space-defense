extends Area2D
## The hull. Forwards damage to RunState (the SSOT).
## Base-side effects (shield, hit flash, …) will live here later.

func take_damage(amount: int) -> void:
	RunState.damage_base(amount)
