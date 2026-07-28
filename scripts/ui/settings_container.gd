class_name Settings
extends Control

signal back_button_pressed

@onready var video_btn: Button = %VideoBtn
@onready var audio_btn: Button = %AudioBtn
@onready var lang_btn: Button = %LangBtn
@onready var back_btn: UI_Button = %BackBtn


@onready var video_settings: GridContainer = %VideoSettings
@onready var audio_settings: GridContainer = %AudioSettings
@onready var language_settings: GridContainer = %LanguageSettings

@onready var resolution: OptionButton = $SettingsContainer/VideoSettings/Resolution
@onready var fullscreen: CheckBox = $SettingsContainer/VideoSettings/Fullscreen
@onready var borderless: CheckBox = $SettingsContainer/VideoSettings/Borderless
@onready var vsync: CheckBox = $SettingsContainer/VideoSettings/Vsync

@onready var master: HSlider = %Master
@onready var music: HSlider = %Music
@onready var sfx: HSlider = %SFX



func _ready() -> void:
	var video_settings_data = ConfigFileHeader.load_video_settings()
	resolution.selected = video_settings_data.resolution
	fullscreen.button_pressed = video_settings_data.fullscreen
	borderless.button_pressed = video_settings_data.borderless
	vsync.button_pressed = video_settings_data.vsync

	var audio_settings_data = ConfigFileHeader.load_audio_settings()
	master.value = min(audio_settings_data.master_volume, 1.0) * 100
	music.value = min(audio_settings_data.music_volume, 1.0) * 100
	sfx.value = min(audio_settings_data.sfx_volume, 1.0) * 100


#region Video Setting Button Signal Code
func _on_video_btn_pressed() -> void:
	video_btn.get_child(0).play()
	hide_settings()
	video_btn.toggle_mode = true
	video_settings.show()

func _on_video_btn_mouse_entered() -> void:
	video_btn.get_child(1).play()
#endregion

#region Audio Setting Button Signal Code
func _on_audio_btn_pressed() -> void:
	audio_btn.get_child(0).play()
	hide_settings()
	audio_btn.toggle_mode = true
	audio_settings.show()

func _on_audio_btn_mouse_entered() -> void:
	audio_btn.get_child(1).play()
#endregion

#region Lang Setting Button Signal Code (may remove)
func _on_lang_btn_pressed() -> void:
	lang_btn.get_child(0).play()
	hide_settings()
	lang_btn.toggle_mode = true
	language_settings.show()

func _on_lang_btn_mouse_entered() -> void:
	lang_btn.get_child(1).play()
#endregion

func hide_settings() -> void:
	video_settings.hide()
	audio_settings.hide()
	language_settings.hide()
	video_btn.toggle_mode = false
	audio_btn.toggle_mode = false
	lang_btn.toggle_mode = false

func _on_back_btn_pressed() -> void:
	back_button_pressed.emit()
	back_btn.get_child(0).play()
	hide()

func _on_back_btn_mouse_entered() -> void:
	back_btn.get_child(1).play()

func _on_resolution_item_selected(index: int) -> void:
	ConfigFileHeader.save_video_setting("resolution", index)

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	ConfigFileHeader.save_video_setting("fullscreen", toggled_on)

func _on_borderless_toggled(toggled_on: bool) -> void:
	ConfigFileHeader.save_video_setting("borderless", toggled_on)

func _on_vsync_toggled(toggled_on: bool) -> void:
	ConfigFileHeader.save_video_setting("vsync", toggled_on)

func _on_master_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHeader.save_audio_settings("master_volume", master.value/100)


func _on_music_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHeader.save_audio_settings("music_volume", music.value/100)

func _on_sfx_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHeader.save_audio_settings("sfx_volume", sfx.value/100)
