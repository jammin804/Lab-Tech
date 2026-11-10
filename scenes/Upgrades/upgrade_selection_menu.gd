class_name UpgradeSelectionMenu
extends Control

@export var tab_container: TabContainer



func _ready() -> void:
	var tree = tab_container.get_children()
	print(tree)


func _on_reset_button_pressed() -> void:
	LevelTransition.change_scene_to("res://scenes/Playground Scenes/playground2.tscn")


func _on_back_to_lab_pressed() -> void:
	hide()
