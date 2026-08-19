extends Node

@export var player : PlayerNew

var lane_distance : float = 60

func _ready() -> void:
	print("Current Player Position ", player.global_position)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		player.global_position += Vector2.ZERO - Vector2(0, lane_distance)
		print(player.global_position)
		print("move up a row")
	if Input.is_action_just_pressed("move_down"):
		player.global_position += Vector2.ZERO + Vector2(0, lane_distance)
		print(player.global_position)
		print("move down a row")
