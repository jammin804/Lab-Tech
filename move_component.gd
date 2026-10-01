extends Node

@export var player : PlayerNew

var lane_distance : float = 40
var is_on_third_floor : bool = false
var is_on_second_floor : bool = false
var is_on_ground_floor : bool = true

func _process(delta: float) -> void:
	_move_player()

func _move_player():
	if Input.is_action_just_pressed("move_up") and is_on_ground_floor:
		_move_up()

		is_on_second_floor = true
		is_on_ground_floor = false
		print("Second floor ", player.global_position)

	elif Input.is_action_just_pressed("move_up") and is_on_second_floor:
		_move_up()

		is_on_third_floor = true
		is_on_second_floor = false
		print("Third floor ", player.global_position)

	elif Input.is_action_just_pressed("move_down") and is_on_third_floor:
		_move_down()

		is_on_third_floor = false
		is_on_second_floor = true
		print("Second floor ", player.global_position)

	elif Input.is_action_just_pressed("move_down") and is_on_second_floor:
		_move_down()

		is_on_second_floor = false
		is_on_ground_floor = true
		print("First floor ", player.global_position)


func _move_down():
	player.global_position += Vector2.ZERO + Vector2(0, lane_distance)

func _move_up():
	player.global_position += Vector2.ZERO - Vector2(0, lane_distance)
