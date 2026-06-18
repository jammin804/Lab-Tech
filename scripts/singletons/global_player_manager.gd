class_name GlobalPlayerManager
extends Node

var starting_stats_ref_path: String = "res://resources/PlayerData/starting_stats.tres"
var current_stats : PlayerStats

func _ready() -> void:
	current_stats = load(starting_stats_ref_path).duplicate()
