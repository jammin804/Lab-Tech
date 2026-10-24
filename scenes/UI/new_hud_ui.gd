class_name HUD
extends CanvasLayer


@onready var num_of_lives_label: Label = %NumOfLivesLabel


func _ready() -> void:
	Events.win_condition_fail.connect(_on_win_condition_failed)
	update_text()

func update_text() -> void:
	num_of_lives_label.text = str(Globals.player_lives)


func _on_win_condition_failed() -> void:
	update_text()
