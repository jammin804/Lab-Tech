extends Control

@onready var pick3_card_container: HBoxContainer = %HBoxContainer
@onready var upgrade_has_been_selected: PanelContainer = $UpgradeSelected

var can_select: bool = true

func _ready() -> void:
	for node:UpgradeCard in pick3_card_container.get_children():
		node.upgrade_selected.connect(_on_upgrade_selected)
	print("Is pick 3 visible? ", pick3_card_container.visible) #BUG 11/9 Find a wa to prevent the node from being select since its invisible or just remove as you send up the upgrade system

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed() and can_select:
		for node:UpgradeCard in pick3_card_container.get_children():
			if node.get_global_rect().has_point(mouse_pos):
				node.apply_upgrade()


func _on_upgrade_selected() -> void:
	pick3_card_container.hide()
	can_select = false
	upgrade_has_been_selected.show()
