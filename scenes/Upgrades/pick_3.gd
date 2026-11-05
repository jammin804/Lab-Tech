extends Control

@onready var pick3_card_container: HBoxContainer = %HBoxContainer
@onready var upgrade_has_been_selected: PanelContainer = $UpgradeSelected

func _ready() -> void:
	for node:UpgradeCard in pick3_card_container.get_children():
		node.upgrade_selected.connect(_on_upgrade_selected)

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		for node:UpgradeCard in pick3_card_container.get_children():
			if node.get_global_rect().has_point(mouse_pos):
				node.apply_upgrade()


func _on_upgrade_selected() -> void:
	pick3_card_container.hide()
	upgrade_has_been_selected.show()
