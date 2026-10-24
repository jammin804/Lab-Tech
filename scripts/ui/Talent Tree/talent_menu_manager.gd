class_name TalentMenuManager
extends Control


const LAB_SCENE = "res://scenes/lab.tscn"

@export_category("Navigation UI")
@export var title_label: Label
@export var left_arrow_btn: TextureButton
@export var right_arrow_btn: TextureButton

@export_category("Skill Trees")
@export var tree_panels: Array[TalentTree2]
@export var tree_names: Array[String]

var current_tab_index: int = 0

func _ready() -> void:
	if left_arrow_btn:
		left_arrow_btn.pressed.connect(_on_left_arrow_pressed)
	if right_arrow_btn:
		right_arrow_btn.pressed.connect(_on_right_arrow_pressed)

	current_tab_index = Events.target_talent_tab

	_update_tab_display()

func _on_left_arrow_pressed() -> void:
	current_tab_index -= 1

	if current_tab_index < 0:
		current_tab_index = tree_panels.size() - 1

	_update_tab_display()


func _on_right_arrow_pressed() -> void:
	current_tab_index += 1

	if current_tab_index >= tree_panels.size():
		current_tab_index = 0

	_update_tab_display()

func _update_tab_display() -> void:
	if tree_panels.is_empty() or tree_names.is_empty():
		return

	title_label.text = tree_names[current_tab_index]

	for i in range(tree_panels.size()):
		if i == current_tab_index:
			tree_panels[i].show()
			tree_panels[i]._on_talent_unhovered()
		else:
			tree_panels[i].hide()


func _on_back_to_lab_pressed() -> void:
	hide()
