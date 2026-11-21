class_name HUD
extends CanvasLayer

#TODO 11/21 Update the money text when the player clicks (LOOK AT PICKUP SCENE) or magnatize (LOOK AT PLAYER SCENE) money an increment the number

@onready var num_of_lives_label: Label = %NumOfLivesLabel
@onready var money_label: Label = %MoneyLabel


func _ready() -> void:
	Events.win_condition_fail.connect(_on_win_condition_failed)
	update_text()

func update_text() -> void:
	var save_data : SaveDataResource = SaveDataResource.new()
	num_of_lives_label.text = str(Globals.player_lives)
	money_label.text = str(save_data.money)
	print("Save Data for UI", save_data.money)


func _on_win_condition_failed() -> void:
	update_text()
