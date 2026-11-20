extends Node2D

@onready var enemy_2: Enemy = %Enemy2



func _on_button_pressed() -> void:
	Globals.enemies_killed += 2
	#Events.return_from_level.emit()
	LevelTransition.change_scene_to("res://scenes/lab.tscn")


func _on_kill_button_pressed() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.destroy()


func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()
