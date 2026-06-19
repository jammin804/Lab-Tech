class_name MainMenu
extends Control

#FIXME The large asset error that appears when I save this scene
@onready var settings_menu: Control = $SettingsMenu
var lab_scene: String = "res://scenes/lab.tscn"

func _ready() -> void:
	var tree = get_tree()
	if tree.paused == true:
		tree.paused = false
	%StartBtn.pressed.connect(play)
	
func play():
	LevelTransition.change_scene_to(lab_scene)
	

func _on_quit_btn_pressed() -> void:
	get_tree().quit()


func _on_settings_btn_pressed() -> void:
	settings_menu.show()


func _on_discord_pressed() -> void:
	OS.shell_open("https://jammin804.itch.io/")


func _on_itch_pressed() -> void:
	OS.shell_open("https://jammin804.itch.io/")


func _on_steam_pressed() -> void:
	OS.shell_open("https://jammin804.itch.io/")
