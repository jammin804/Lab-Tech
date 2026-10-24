class_name Levels
extends Resource

@export var enemies_to_defeat: int
@export var enemies_to_spawn : int
@export var enemies_type : Array[PackedScene]

func _init(p_num_to_kill = 1, p_num_to_spawn = 1) -> void:
	enemies_to_defeat = p_num_to_kill
	enemies_to_spawn = p_num_to_spawn
	enemies_type = [preload("uid://cqueta70ubjqr")]
