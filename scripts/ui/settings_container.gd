extends Control

@onready var video_btn: Button = %VideoBtn
@onready var audio_btn: Button = %AudioBtn
@onready var lang_btn: Button = %LangBtn
@onready var back_btn: UI_Button = %BackBtn


@onready var video_settings: GridContainer = %VideoSettings
@onready var audio_settings: GridContainer = %AudioSettings
@onready var language_settings: GridContainer = %LanguageSettings

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
	back_btn.get_child(0).play()
	hide()

func _on_back_btn_mouse_entered() -> void:
	back_btn.get_child(1).play()
