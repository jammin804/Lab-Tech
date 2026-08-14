class_name GameManager
extends Node2D


@export_category("Debug Varibles")
@export var toggle_debug : bool = false

@export_category("Energy Resource")
@export var current_energy: int
@export var max_energy: int

@export_category("Menu UI Components")
@export var pause_menu: PauseMenu
@export var settings_menu: Settings

@export_category("Levels")
@export var levels : Array[String]

var is_option_menu_open : bool = false
var main_menu: String = "res://scenes/main_menu.tscn"
var level_1: String = "uid://bdpj78s126rdu"



@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var resource_numbers: Label = %ResourceNumbers
@onready var player: Player = %Player

# Scenes
@onready var upgrade_screen: Control = %UpgradeScreen

#UI
@onready var end_level_pop_up: CanvasLayer = %EndLevelPopUp
@onready var skill_tree: Control = %SkillTree
@onready var talent_menu_manager: TalentMenuManager = %TalentMenuManager


@onready var resume_btn: UI_Button = %ResumeBtn
@onready var options_btn: UI_Button = %OptionsBtn
@onready var quit_btn: UI_Button = %QuitBtn


#TODO I have alot of repeated code in each level


func _ready() -> void:
	if Engine.time_scale < 1.0:
		Engine.time_scale = 1.0

	var tree = get_tree()
	if tree.paused == true:
		tree.paused = false
	animation_player.play("scale_squish")

	hide_menu()

	pause_menu.resume_game.connect(_on_resume_btn_pressed)
	pause_menu.open_options.connect(_on_options_btn_pressed)
	pause_menu.exit_to_title.connect(_on_quit_btn_pressed)
	settings_menu.back_button_pressed.connect(_on_back_btn_pressed)
	LevelTransition.scene_loading_finished.connect(_on_scene_loading_finished)


func _process(delta: float) -> void:
	pass

func update_energy() -> void:
	if current_energy < max_energy:
		current_energy += 1
	else:
		current_energy = max_energy
	resource_numbers.text = str(current_energy) + "/ " + str(max_energy)

func hide_menu() -> void:
	if settings_menu == null:
		return
	settings_menu.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_option_menu_open:
			#print("Close Option Menu")
			settings_menu.visible = false
			is_option_menu_open = false

		toggle_pause()

func _on_battle_btn_pressed() -> void:
	#TODO Have a function or a condition to check when level the player is currently on then send them to that level
	print("Transitioning from Lab to Level 1")
	LevelTransition.change_scene_to(level_1)

func _on_pause_btn_pressed() -> void:
	toggle_pause()

func _on_back_btn_pressed() -> void:
	settings_menu.visible = false
	pause_menu.show()

func toggle_pause() -> void:
	var tree = get_tree()
	tree.paused = !tree.paused
	pause_menu.visible = tree.paused

func _on_resume_btn_pressed() -> void:
	toggle_pause()

func _on_quit_btn_pressed() -> void:
	LevelTransition.change_scene_to(main_menu)

func _on_options_btn_pressed() -> void:
	is_option_menu_open = true
	settings_menu.visible = true
	pause_menu.hide()


func _on_upgrades_btn_pressed() -> void:
	talent_menu_manager.show()


func _on_scene_loading_finished() -> void:
	print("Start Music")
	#TODO Think about if we should wait until the full load because game start. As of now wait
