class_name ZoneComplete
extends Control

signal go_to_next_stage
signal open_upgrade_screen


func _on_zone_button_pressed() -> void:
	#print("Go to next scene")
	go_to_next_stage.emit()


func _on_upgrade_button_pressed() -> void:
	#print("Open UI")
	open_upgrade_screen.emit()
