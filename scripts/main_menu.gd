class_name MainMenu
extends Control

#FIXME The large asset error that appears when I save this scene
@onready var settings_menu: Control = $SettingsMenu
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var lab_scene: String = "res://scenes/lab.tscn"
var level_1: String = "res://scenes/Levels/battle_screen.tscn"

func _ready() -> void:
	if $MainMenmBGM.Volume < -10.0:
		$MainMenmBGM.Volume = -10.0
		
	var tree = get_tree()
	if tree.paused == true:
		tree.paused = false
	%StartBtn.pressed.connect(play)
	
func play():
	%StartBtn.disabled = true
	animation_player.play("blink")
	$MainMenmBGM.Volume = -80.0
	await get_tree().create_timer(1.0).timeout
	LevelTransition.change_scene_to(level_1)
	

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
