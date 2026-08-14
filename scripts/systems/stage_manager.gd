class_name StageManager
extends CanvasLayer

signal scene_loading_finished

@export var levels : Array[String]

var scene_to_load : String
var active_level : Node2D


@onready var transition_player: AnimationPlayer = $TransitionPlayer
#TODO Fix timing for music to start and stop after level loads
func _ready() -> void:
	visible = false
	pass

func change_scene_to(scene_path: String) -> void:
	visible = true
	scene_to_load = scene_path
	transition_player.play("transition")
	get_tree().paused = true
	await transition_player.animation_finished
	_load_new_scene()

func _load_new_scene() -> void:
	get_tree().paused = false
	transition_player.play_backwards("transition")
	get_tree().call_deferred("change_scene_to_file", scene_to_load)
	await transition_player.animation_finished
	visible = false
	scene_loading_finished.emit()


func _on_change_level() -> void: #FIXME Remove. Not being used
	match Globals.level:
		1:
			print("Go to level 1")
			change_scene_to(levels[0])
		2:
			print("Go to level 2")
		3:
			print("Go to level 3")
