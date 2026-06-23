class_name Level_1
extends Node

@export_category("Menu UI Components")
@export var pause_menu: PauseMenu
@export var settings_menu: Settings
@export var player : PackedScene = preload("res://scenes/battle_player.tscn")

var main_menu : String = "res://scenes/main_menu.tscn"
var is_option_menu_open : bool = false

func _ready() -> void:
	#Load player at spawn
	#TODO Need to create a load data for the player to save information between scenes
	var player_inst = player.instantiate()
	$Pausable.add_child(player_inst)
	player_inst.global_position = %PlayerSpawnPoint.global_position
	
	#TODO Increment level on the global level so the lab/upgrade scene can see it
	Globals.level = 1
	
	pause_menu.resume_game.connect(_on_resume_btn_pressed)
	pause_menu.open_options.connect(_on_options_btn_pressed)
	pause_menu.exit_to_title.connect(_on_quit_btn_pressed)
	settings_menu.back_button_pressed.connect(_on_back_btn_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_option_menu_open:
			print("Close Option Menu")
			settings_menu.visible = false
			is_option_menu_open = false
			
		toggle_pause()

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
