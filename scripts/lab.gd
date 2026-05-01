extends Control

@onready var cta: Label = $CTA
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var clicker: Clicker = $Clicker
@onready var resource_numbers: Label = $PanelContainer/MarginContainer/StatsResourceDisplay/ResourceDisplay/ResourceNumbers

@export_category("Energy Resource")
@export var current_energy: int
@export var max_energy: int


func _ready() -> void:
	clicker.connect("clicker_pressed", update_energy)
	animation_player.play("scale_squish")


func update_energy() -> void:
	if current_energy < max_energy:
		current_energy += 1
	else:
		current_energy = max_energy
	resource_numbers.text = str(current_energy) + "/ " + str(max_energy)
