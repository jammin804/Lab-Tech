class_name TalentSelectionMenu
extends Control

@export var arm_button: Button
@export var body_button: Button

const TALENT_MENU_MANAGER_SCENE = "res://scenes/UI/New Talent Tree/talent_menu_manager.tscn"
const LAB_SCENE = "res://scenes/lab.tscn"

func _ready() -> void:
	if arm_button:
		arm_button.pressed.connect(_on_arms_selected)
	if body_button:
		body_button.pressed.connect(_on_body_selected)

func _on_arms_selected() -> void:
	Events.target_talent_tab = 0
	LevelTransition.change_scene_to(TALENT_MENU_MANAGER_SCENE)

func _on_body_selected() -> void:
	Events.target_talent_tab = 1
	LevelTransition.change_scene_to(TALENT_MENU_MANAGER_SCENE)


func _on_back_to_lab_pressed() -> void:
	LevelTransition.change_scene_to(LAB_SCENE)
