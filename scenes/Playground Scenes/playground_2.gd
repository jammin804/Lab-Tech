extends Node2D




func _on_button_pressed() -> void:
	Globals.enemies_killed += 2
	#Events.return_from_level.emit()
	LevelTransition.change_scene_to("res://scenes/lab.tscn")
