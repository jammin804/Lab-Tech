class_name Level_1
extends Node

@export_category("Menu UI Components")
@export var pause_menu: PauseMenu
@export var settings_menu: Settings
@export var player : PackedScene = null
@export var player_spawn : Marker2D

var main_menu : String = "res://scenes/main_menu.tscn"
var lab : String = "uid://dmqv875jehqwm"
var is_option_menu_open : bool = false
var is_result_screen_open : bool = false

var enemies_to_defeat: int = 0
var enemies_defeated: int = 0
var total_enemies_defeated : int = 0
var total_damage_done : int = 0
var total_player_damage_taken : int = 0
var total_money_gained: int = 0
var total_scraps_gained : int = 0
var total_cores_gained : int = 0
var status = ""
var grade = ""

@onready var result_screen: Result_Screen = $ResultScreen
@onready var wave_label: Label = $Pausable/WaveLabel
@onready var enemies_in_wave_label: Label = $Pausable/EnemiesInWaveLabel
@onready var enemy_spawner: Enemy_Spawner = %EnemySpawner
@onready var money_label: Label = %MoneyLabel

func _ready() -> void:
	#Load player at spawn
	#TODO Need to create a load data for the player to save information between scenes
	var player_inst = player.instantiate()
	$Pausable.add_child(player_inst)
	player_inst.global_position = %PlayerSpawnPoint.global_position
	money_label.text = str("$",total_money_gained)

	#TODO Increment level on the global level so the lab/upgrade scene can see it
	Globals.level = 1

	pause_menu.resume_game.connect(_on_resume_btn_pressed)
	pause_menu.open_options.connect(_on_options_btn_pressed)
	pause_menu.retreat.connect(_on_retreat_button_pressed)
	pause_menu.exit_to_title.connect(_on_quit_btn_pressed)
	settings_menu.back_button_pressed.connect(_on_back_btn_pressed)
	Events.level_complete.connect(_on_result_screen_shown)
	Events.wave_completed.connect(_on_wave_change)
	Events.enemy_died.connect(_update_enemy_counter)
	Events.damage_dealt.connect(_on_damage_done)
	Events.damage_taken.connect(_on_player_damage_taken)
	Events.increase_currency.connect(_on_currency_gained)

	_reset_flags()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"): #and is_result_screen_open == false:
		if is_option_menu_open:
			print("Close Option Menu")
			settings_menu.visible = false
			is_option_menu_open = false

		toggle_pause()

func _on_wave_change(current_wave: int, number_defeated: int) -> void:


	if current_wave == 2:
		print("Run level complete script")
		Events.show_result_screen.emit(total_enemies_defeated, total_damage_done, total_player_damage_taken, total_money_gained, total_scraps_gained, total_cores_gained, status, grade)


	update_wave_counter(number_defeated)

	wave_label.text = "Wave: "+ str(current_wave)

	print("Check to go to next level")



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

func _on_retreat_button_pressed() -> void:
	LevelTransition.change_scene_to(lab)

func _on_options_btn_pressed() -> void:
	is_option_menu_open = true
	settings_menu.visible = true
	pause_menu.hide()

func _on_result_screen_shown() -> void:
	result_screen.show()
	is_result_screen_open = true

func _reset_flags() -> void:
	if is_result_screen_open == true:
		is_result_screen_open = false


func _update_enemy_counter() -> void:
	enemies_defeated += 1
	total_enemies_defeated += 1

	enemies_in_wave_label.text = str(enemies_defeated) + "/" + str(enemies_to_defeat)


func _on_damage_done() -> void:
	total_damage_done += 1

func _reset_level_stats() -> void:
	total_enemies_defeated = 0
	total_damage_done = 0
	total_player_damage_taken = 0


func _on_player_damage_taken(amount: int) -> void:
	total_player_damage_taken += amount


func update_wave_counter(number_defeated: int):
	enemies_to_defeat = %EnemySpawner.number_enemies_in_wave

	enemies_in_wave_label.text = str(number_defeated) + "/" + str(enemies_to_defeat)


func _on_currency_gained(amount: int) -> void:
	total_money_gained += amount
	money_label.text = str("$", total_money_gained)
