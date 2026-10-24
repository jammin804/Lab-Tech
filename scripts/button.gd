class_name UI_Button
extends Button

@export var click: AudioStreamPlayer
@export var hover: AudioStreamPlayer
#@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	text = text.to_upper()

func _on_pressed() -> void:
	click.play()
	#animation_player.play("flash")
	#await get_tree().create_timer(1.0).timeout
	#animation_player.stop()

func _on_mouse_entered() -> void:
	hover.play()
