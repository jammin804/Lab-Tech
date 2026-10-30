extends Node2D




func _on_button_pressed() -> void:
	Globals.enemies_killed += 19
	LevelTransition.change_scene_to("res://scenes/lab.tscn")
