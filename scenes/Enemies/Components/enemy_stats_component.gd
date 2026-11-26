class_name EnemyStatsComponent
extends Node

@export var enemy_stats: EnemyStats

var _move_speed: float

func _ready() -> void:
	_move_speed = enemy_stats.move_speed
	print("Stat Componenet ", _move_speed)

func setup() -> void:
	pass
