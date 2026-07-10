class_name StageManager
extends CanvasLayer

@export var levels : Array[String] 

var scene_to_load : String
var active_level : Node2D


@onready var transition_player: AnimationPlayer = $TransitionPlayer

func _ready() -> void:
	#print(levels.size())
	pass

func change_scene_to(scene_path: String) -> void:
	scene_to_load = scene_path
	transition_player.play("fade_out")
	get_tree().paused = true

func _load_new_scene() -> void:
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", scene_to_load)
	transition_player.play("fade_in")


func _on_transition_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		_load_new_scene()
		
func _on_change_level() -> void:
	match Globals.level:
		1:
			print("Go to level 1")
			change_scene_to(levels[0])
		2:
			print("Go to level 2")
		3:
			print("Go to level 3")
