extends Node

@export var player : PlayerNew

var lane_distance : float = 60


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		player.global_position += Vector2.ZERO - Vector2(0, lane_distance)
	if Input.is_action_just_pressed("move_down"):
		player.global_position += Vector2.ZERO + Vector2(0, lane_distance)
