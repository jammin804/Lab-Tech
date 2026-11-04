extends Control

@onready var pick3_card_container: HBoxContainer = %HBoxContainer
@onready var upgrade_has_been_selected: PanelContainer = $UpgradeSelected

func _ready() -> void:
	for node:UpgradeCard in pick3_card_container.get_children():
		node.upgrade_selected.connect(_on_upgrade_selected)

func _input(event: InputEvent) -> void:
	#TODO 11/4 [URGENT] finish the implimentation of the selection of an upgrade
	var mouse_pos = get_global_mouse_position()
	if event is InputEventMouse and event.button_index == 1:
		pass

func _on_upgrade_selected() -> void:
	pick3_card_container.hide()
	upgrade_has_been_selected.show()
