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
@export var zones : Array[Zones] = [null]
@export var levels : Array[String] = []
var zone_info : Zones
var zone_index : int = 0

var is_option_menu_open : bool = false
var main_menu: String = "res://scenes/main_menu.tscn"
var level_1: String #"uid://bdpj78s126rdu"
var level: String



@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var resource_numbers: Label = %ResourceNumbers
@onready var player: Player = %Player

# Scenes
@onready var upgrade_screen: Control = %UpgradeScreen

#UI
@onready var end_level_pop_up: CanvasLayer = %EndLevelPopUp
@onready var skill_tree: Control = %SkillTree
@onready var talent_menu_manager: TalentMenuManager = %TalentMenuManager
@onready var lab_gui: LabGui = $CanvasLayer/LabGui



@onready var resume_btn: UI_Button = %ResumeBtn
@onready var options_btn: UI_Button = %OptionsBtn
@onready var quit_btn: UI_Button = %QuitBtn


#TODO I have alot of repeated code in each level


func _ready() -> void:
	print("Num of enemies killed ", Globals.enemies_killed)
	if Engine.time_scale < 1.0:
		Engine.time_scale = 1.0

	var tree = get_tree()
	if tree.paused == true:
		tree.paused = false
	animation_player.play("scale_squish")

	hide_menu()

	#Initializing signals

	pause_menu.resume_game.connect(_on_resume_btn_pressed)
	pause_menu.open_options.connect(_on_options_btn_pressed)
	pause_menu.exit_to_title.connect(_on_quit_btn_pressed)
	settings_menu.back_button_pressed.connect(_on_back_btn_pressed)
	LevelTransition.scene_loading_finished.connect(_on_scene_loading_finished)

	level = levels[zone_index]

	zone_info = zones[zone_index]
	lab_gui.initialize(zone_info.zone_name, zone_info.zone_requirement, zone_info.waves_left_to_complete_goal)

func update_energy() -> void:
	if current_energy < max_energy:
		current_energy += 1
	else:
		current_energy = max_energy
	resource_numbers.text = str(current_energy) + "/ " + str(max_energy)


func level_up():
	Globals.zone += 1
	zone_index = Globals.zone - 1
	#get_new_level()


func get_new_level() -> String:
	return levels[zone_index]


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

func toggle_pause() -> void:
	var tree = get_tree()
	tree.paused = !tree.paused
	pause_menu.visible = tree.paused


func _on_battle_btn_pressed() -> void:
	#TODO Have a function or a condition to check when level the player is currently on then send them to that level
	#print("Transitioning from Lab to ", str(levels[zone_index]))
	LevelTransition.change_scene_to(level)

#region Settins and UI signals
func _on_pause_btn_pressed() -> void:
	toggle_pause()

func _on_back_btn_pressed() -> void:
	settings_menu.visible = false
	pause_menu.show()


func _on_resume_btn_pressed() -> void:
	toggle_pause()

func _on_quit_btn_pressed() -> void:
	LevelTransition.change_scene_to(main_menu)

func _on_options_btn_pressed() -> void:
	is_option_menu_open = true
	settings_menu.visible = true
	pause_menu.hide()

#endregion

func _on_upgrades_btn_pressed() -> void:
	talent_menu_manager.show()

func _on_scene_loading_finished() -> void:
	print("Start Music")

	print("Start Animation")

	lab_gui.update_progress_bar(Globals.previous_killed, Globals.enemies_killed)
	Globals.previous_killed = Globals.enemies_killed
	#Events.lab_transition_finished.emit()


func _on_test_button_pressed() -> void:
	LevelTransition.change_scene_to("res://scenes/Playground Scenes/playground2.tscn")
