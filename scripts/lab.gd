class_name GameManager
extends Control

signal battle_scene_start
signal uprgrade_scene_start

@export_category("Energy Resource")
@export var current_energy: int
@export var max_energy: int

var is_in_battle_scene : bool = false

@onready var cta: Label = $CTA
@onready var clicker: Clicker = %Clicker
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var resource_numbers: Label = %ResourceNumbers

# Scenes
@onready var upgrade_screen: Control = %UpgradeScreen
@onready var battle_screen: Control = %BattleScreen
@onready var popups: Control = $BattleScreen/Popups

#UI
@onready var end_level_pop_up: CanvasLayer = %EndLevelPopUp

func _ready() -> void:
	clicker.connect("clicker_pressed", update_energy)
	animation_player.play("scale_squish")


func update_energy() -> void:
	if current_energy < max_energy:
		current_energy += 1
	else:
		current_energy = max_energy
	resource_numbers.text = str(current_energy) + "/ " + str(max_energy)



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
