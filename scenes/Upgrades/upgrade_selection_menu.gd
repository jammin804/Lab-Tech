class_name UpgradeSelectionMenu
extends Control

@export var tab_container: TabContainer



func _ready() -> void:
	var tree = tab_container.get_children()
	print(tree)
