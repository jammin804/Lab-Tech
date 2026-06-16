class_name SpawnInfo
extends Resource

enum SpawnZone {GROUND, SKY}
@export var zone: SpawnZone = SpawnZone.GROUND
@export var enemy_scene : PackedScene
@export var enemy_count : int = 1
@export var spawn_delay : float = 0.5
@export var spawn_group_name: String = "ground_spawns"
