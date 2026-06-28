class_name Persistence
extends Node2D

@onready var bonus_stats : PlayerStats = PlayerStats.new()

func gain_bonus_stats(player : PlayerManager) -> void:
	var player_stats = player.current_stats
	player_stats.battery_tank += bonus_stats.battery_tanks
	player_stats.power += bonus_stats.power
	player_stats.charge_rate += bonus_stats.charge_rate
	player_stats.auto_fire += bonus_stats.auto_fire
	player_stats.can_charge += bonus_stats.can_charge
	pass
