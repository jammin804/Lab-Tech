class_name HUD
extends CanvasLayer


@onready var num_of_lives_label: Label = %NumOfLivesLabel


func _ready() -> void:
	num_of_lives_label.text = str(Globals.player_levels)
