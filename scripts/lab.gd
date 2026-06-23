class_name GameManager
extends Node2D

#signal battle_scene_start
#signal uprgrade_scene_start

@export_category("Debug Varibles")
@export var toggle_debug : bool = false

@export_category("Energy Resource")
@export var current_energy: int
@export var max_energy: int

var is_option_menu_open : bool = false
var main_menu: String = "res://scenes/main_menu.tscn"

@export_category("Menu UI Components")
@export var pause_menu: PauseMenu
@export var settings_menu: Settings

@export_category("Levels")
@export var levels : Array[String]

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var resource_numbers: Label = %ResourceNumbers
@onready var player: Player = %Player

# Scenes
@onready var upgrade_screen: Control = %UpgradeScreen
@onready var battle_screen: Control = %BattleScreen
@onready var popups: Control = $BattleScreen/Popups

#UI
@onready var end_level_pop_up: CanvasLayer = %EndLevelPopUp
#@onready var settings_menu: Control = $SettingsMenu

@onready var resume_btn: UI_Button = %ResumeBtn
@onready var options_btn: UI_Button = %OptionsBtn
@onready var quit_btn: UI_Button = %QuitBtn


#TODO I have alot of repeated code in each level


func _ready() -> void:
	var tree = get_tree()
	if tree.paused == true:
		tree.paused = false
	#clicker.connect("clicker_pressed", update_energy)
	animation_player.play("scale_squish")
	
	hide_menu()
	
	pause_menu.resume_game.connect(_on_resume_btn_pressed)
	pause_menu.open_options.connect(_on_options_btn_pressed)
	pause_menu.exit_to_title.connect(_on_quit_btn_pressed)

func _process(delta: float) -> void:
	if toggle_debug:
		if Input.is_action_just_pressed("ui_accept"):
			player.current_health -= 10

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
			print("Close Option Menu")
			settings_menu.visible = false
			is_option_menu_open = false
			
		toggle_pause()

func _on_battle_btn_pressed() -> void:
	#TODO Have a function or a condition to check when level the player is currently on then send them to that level
	LevelTransition.change_scene_to(levels[0])
	
	
func _on_return_to_lab_btn_pressed() -> void: #TODO: Add a signal to event bus to send back to lab sceen
	end_level_pop_up.visible = false
	emit_signal("uprgrade_scene_start")
	#LevelTransition.change_scene_to(lab)


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
	#TODO: Open the skill tree
	pass # Replace with function body.
