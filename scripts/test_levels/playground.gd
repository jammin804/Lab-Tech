extends Node2D

@export var player_scene : PackedScene
@onready var player_spawn_point: Marker2D = $PlayerSpawnPoint

func _ready() -> void:
	var player_instance : Player = player_scene.instantiate()
	player_instance.global_position = player_spawn_point.global_position
	add_child(player_instance)
	
	#Plass the fresh node to the manager to restore its health state
	PlayerManager.load_player_state(player_instance)
