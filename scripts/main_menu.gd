class_name MainMenu
extends Control

func _ready() -> void:
	%StartBtn.pressed.connect(play)

func play():
	get_tree().change_scene_to_file("res://scenes/lab.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()


func _on_settings_btn_pressed() -> void:
	%SettingsPanelContainer.show()
