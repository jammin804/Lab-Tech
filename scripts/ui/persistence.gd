extends Node2D

@onready var bonus_stats : PlayerStats = PlayerStats.new()

func gain_bonus_stats() -> void:
	var player_stats = PlayerManager.current_stats
	
	player_stats.super_click = player_stats.super_click or bonus_stats.super_click
	player_stats.auto_fire = player_stats.auto_fire or bonus_stats.auto_fire
	player_stats.can_charge = player_stats.can_charge or bonus_stats.can_charge
	
	player_stats.charge_damage_multipler += bonus_stats.charge_damage_multipler
	player_stats.charge_rate = bonus_stats.charge_rate
	player_stats.battery_tanks += bonus_stats.battery_tanks
	player_stats.power += bonus_stats.power
	player_stats.damage_multipler += bonus_stats.damage_multipler
	player_stats.rapid += bonus_stats.rapid
	
