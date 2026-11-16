class_name GameOver
extends Control

signal reset_zone


func _on_retry_zone_button_pressed() -> void:
	reset_zone.emit()


func _on_return_to_main_button_pressed() -> void:
	LevelTransition.change_scene_to("res://scenes/main_menu.tscn")


func _on_return_to_title_btn_pressed() -> void:
	LevelTransition.change_scene_to("res://scenes/main_menu.tscn")


func _on_visibility_changed() -> void:
	$GameOverMusic.play()
