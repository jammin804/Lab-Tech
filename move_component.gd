extends Node

@export var player : PlayerNew

var lane_distance : float = 60
var is_on_second_floor : bool = false
var is_on_ground_floor : bool = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up") and is_on_ground_floor:
		player.global_position += Vector2.ZERO - Vector2(0, lane_distance)
		is_on_second_floor = true
		is_on_ground_floor = false

	if Input.is_action_just_pressed("move_down") and is_on_second_floor:
		player.global_position += Vector2.ZERO + Vector2(0, lane_distance)
		is_on_second_floor = false
		is_on_ground_floor = true
