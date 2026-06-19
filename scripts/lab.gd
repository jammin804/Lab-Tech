class_name GameManager
extends Control

signal battle_scene_start
signal uprgrade_scene_start

@export_category("Debug Varibles")
@export var toggle_debug : bool = false

@export_category("Energy Resource")
@export var current_energy: int
@export var max_energy: int

var is_in_battle_scene : bool = false
var main_menu: String = "res://scenes/main_menu.tscn"

@export_category("Menu UI Components")
@export var pause_menu: Control
@export var settings_menu: Control

@onready var cta: Label = $CTA
@onready var clicker: Clicker = %Clicker
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

#Input
@export var pause_action = "pause"

#FIXME Currently player can unpause while in options menu


func _ready() -> void:
	var tree = get_tree()
	if tree.paused == true:
		tree.paused = false
	clicker.connect("clicker_pressed", update_energy)
	animation_player.play("scale_squish")
	
	hide_menu()

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

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(pause_action):
		toggle_pause()

func _on_battle_btn_pressed() -> void:
	upgrade_screen.visible = false
	is_in_battle_scene = true
	battle_screen.visible = true
	emit_signal("battle_scene_start")
	
	
func _on_return_to_lab_btn_pressed() -> void:
	upgrade_screen.visible = true
	is_in_battle_scene = false
	battle_screen.visible = false
	end_level_pop_up.visible = false
	emit_signal("uprgrade_scene_start")


func _on_pause_btn_pressed() -> void:
	#get_tree().paused = true
	toggle_pause()
	#settings_menu.show()

func _on_back_btn_pressed() -> void:
	#get_tree().paused = false
	toggle_pause()
	#settings_menu.hide()
	
func toggle_pause() -> void:
	var tree = get_tree()
	tree.paused = !tree.paused
	pause_menu.visible = tree.paused
	#settings_menu.visible = !tree.paused


func _on_resume_btn_pressed() -> void:
	toggle_pause()


func _on_options_btn_pressed() -> void:
	settings_menu.visible = true


func _on_quit_btn_pressed() -> void:
	LevelTransition.change_scene_to(main_menu)
	
func hide_menu() -> void:
	settings_menu.hide()
	pause_menu.hide()
