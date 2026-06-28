extends Node

@export var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
@export var canister_collectable_scene: PackedScene = preload("res://scenes/Currency/pickups.tscn")

@onready var player : Player = $Player

func spawn_canister() -> void:
	var new_canister = canister_collectable_scene.instantiate()
	new_canister.setup(player)
	add_child(new_canister) 
