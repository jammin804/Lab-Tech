class_name EnemyHealthComponent
extends Node

@export var enemy_stats: EnemyStatsComponent

var current_enemy_hp
var max_enemy_hp


func _ready() -> void:
	current_enemy_hp = enemy_stats.enemy_stats.health
	current_enemy_hp = floor( (current_enemy_hp + 10) * Globals.level * randf_range(1.0, 1.5) )

	max_enemy_hp = current_enemy_hp

	update_hp_label()

func update_hp_label():
	return
