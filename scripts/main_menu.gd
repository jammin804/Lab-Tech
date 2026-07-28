class_name MainMenu
extends Control

#FIXME The large asset error that appears when I save this scene
@onready var settings_menu: Control = $SettingsMenu
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var continue_btn: UI_Button = %ContinueBtn
@onready var start_btn: UI_Button = %StartBtn

var lab_scene: String = "res://scenes/lab.tscn"
var level_1: String = "res://scenes/Levels/battle_screen.tscn"

func _ready() -> void:
	if $MainMenmBGM.Volume < -10.0:
		$MainMenmBGM.Volume = -10.0

	var tree = get_tree()
	if tree.paused == true:
		tree.paused = false

	if SaveData.has_save_file():
		continue_btn.show()
		continue_btn.pressed.connect(_on_continue_pressed)
	else:
		continue_btn.hide()

	start_btn.pressed.connect(_on_start_new_game_pressed)




func _on_continue_pressed() -> void:
	continue_btn.release_focus()
	#continue_btn.disabled = true
	#start_btn.disabled = true

	SaveData._load()
	_play_transiiton(lab_scene, "continue_blink")

func _on_start_new_game_pressed() -> void:
	start_btn.release_focus()
	#if continue_btn:
		#continue_btn.disabled = true
	#start_btn.disabled = true

	SaveData.reset_save()
	_play_transiiton(level_1, "blink")


func _play_transiiton(target_scene: String, anim_name: String) -> void:
	animation_player.play(anim_name)
	$MainMenmBGM.Volume = -80.0
	await get_tree().create_timer(1.0).timeout
	LevelTransition.change_scene_to(target_scene)



func _on_quit_btn_pressed() -> void:
	get_tree().quit()


func _on_settings_btn_pressed() -> void:
	animation_player.play("settings_blink")
	await get_tree().create_timer(1.0).timeout
	settings_menu.show()
	animation_player.play("RESET")



func _on_discord_pressed() -> void:
	OS.shell_open("https://jammin804.itch.io/")


func _on_itch_pressed() -> void:
	OS.shell_open("https://jammin804.itch.io/")


func _on_steam_pressed() -> void:
	OS.shell_open("https://jammin804.itch.io/")
