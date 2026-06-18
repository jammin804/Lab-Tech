class_name StageManager
extends CanvasLayer

var level_dict : Dictionary = {
	1: preload("res://scenes/Playground Scenes/playground.tscn"),
	2: preload("res://scenes/Playground Scenes/playground2.tscn"),
	3: preload("res://scenes/Playground Scenes/playground3.tscn"),
}

var stored_level : PackedScene
var active_level : Node2D

@onready var transition_player: AnimationPlayer = $TransitionPlayer

func _change_stage(level_number: int) -> void:
	if level_number in level_dict:
		stored_level = level_dict[level_number]
		
		if active_level and stored_level.resource_path == active_level.scene_file_path:
			return
			
		transition_player.play("fade_out")


func _on_transition_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		if active_level:
			active_level.queue_free()
		active_level = stored_level.instantiate()
		$StageContainer.add_child(active_level)
		transition_player.play("fade_in")
		
	if anim_name == "fade_in":
		stored_level = null
