extends Node

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		print("move up a row")
	if Input.is_action_just_pressed("move_down"):
		print("move down a row")
