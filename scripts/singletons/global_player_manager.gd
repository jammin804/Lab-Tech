class_name GlobalPlayerManager
extends Node

#FIXME Ask if there is a better way (or simpiler way) to move player to another scene with current hp unless its a new level or play just visited the lab to heal and upgrade
var starting_stats_ref_path: String = "res://resources/PlayerData/starting_stats.tres"
var current_stats : PlayerStats
var current_health_cache: float = -1.0
var should_restore_player: bool = false
var active_player : Node2D
var player_position : Vector2


func _ready() -> void:
	current_stats = load(starting_stats_ref_path).duplicate()

func save_player_state(player: Player) -> void:
	current_health_cache = player.current_health

func load_player_state(player: Player) -> void:
	if should_restore_player or current_health_cache < 0:
		# Full restore context (Upgrade Scene or first loade)
		player.current_health = player.max_health
		should_restore_player = false
	else:
		player.current_health = current_health_cache
