class_name PauseMenu
extends Control

signal resume_game
signal exit_to_title
signal open_options

@onready var resume_btn: UI_Button = %ResumeBtn
@onready var options_btn: UI_Button = %OptionsBtn
@onready var quit_btn: UI_Button = %QuitBtn



func _on_resume_btn_pressed() -> void:
	emit_signal("resume_game")


func _on_options_btn_pressed() -> void:
	emit_signal("open_options")
	print("open_options hase been emited")


func _on_quit_btn_pressed() -> void:
	emit_signal("exit_to_title")
	print("quit_game hase been emited")
	
