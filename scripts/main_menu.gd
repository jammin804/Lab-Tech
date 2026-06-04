class_name MainMenu
extends Control


@onready var video_btn: Button = %VideoBtn
@onready var audio_btn: Button = %AudioBtn
@onready var lang_btn: Button = %LangBtn

@onready var video_settings: GridContainer = %VideoSettings
@onready var audio_settings: GridContainer = %AudioSettings
@onready var language_settings: GridContainer = %LanguageSettings
@onready var settings_menu: Control = $SettingsMenu


func _ready() -> void:
	%StartBtn.pressed.connect(play)
	
func play():
	get_tree().change_scene_to_file("res://scenes/lab.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()


func _on_settings_btn_pressed() -> void:
	settings_menu.show()


func _on_video_btn_pressed() -> void:
	video_btn.get_child(0).play()
	hide_settings()
	video_btn.toggle_mode = true
	video_settings.show()



func _on_audio_btn_pressed() -> void:
	audio_btn.get_child(0).play()
	hide_settings()
	audio_btn.toggle_mode = true
	audio_settings.show()


func _on_lang_btn_pressed() -> void:
	lang_btn.get_child(0).play()
	hide_settings()
	lang_btn.toggle_mode = true
	language_settings.show()


func hide_settings() -> void:
	video_settings.hide()
	audio_settings.hide()
	language_settings.hide()
	video_btn.toggle_mode = false
	audio_btn.toggle_mode = false
	lang_btn.toggle_mode = false
	


func _on_back_btn_pressed() -> void:
	settings_menu.hide()


func _on_discord_pressed() -> void:
	OS.shell_open("https://jammin804.itch.io/")


func _on_itch_pressed() -> void:
	OS.shell_open("https://jammin804.itch.io/")


func _on_steam_pressed() -> void:
	OS.shell_open("https://jammin804.itch.io/")
