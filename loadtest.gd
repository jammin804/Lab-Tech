extends Node2D


func _on_button_pressed() -> void:
	LoadingSystem.load_scene("res://scenes/Levels/level_1.tscn")
