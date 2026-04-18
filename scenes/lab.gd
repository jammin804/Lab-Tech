extends Control

@onready var cta: Label = $CTA
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export_category("Energy Resource")
@export var current_energy: int
@export var max_energy: int

func _ready() -> void:
	animation_player.play("scale_squish")
