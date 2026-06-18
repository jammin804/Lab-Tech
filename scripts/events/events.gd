extends Node

signal player_spawned(player_ref: Player)
signal enemy_hit_by_projectile(drain_amount: int)
signal wave_complted(current_wave: int)
signal boss_health_changed(new_health: int, max_health: int)
signal screen_shake_requested(intensity: float, duration: float)
