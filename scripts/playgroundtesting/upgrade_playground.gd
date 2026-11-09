extends Control

@export var player: PlayerNew


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_SPACE:
			print(player.firing_component.bullet_strength)
