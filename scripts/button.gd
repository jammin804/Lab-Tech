extends Button

@export var click: AudioStreamPlayer
@export var hover: AudioStreamPlayer

func _ready() -> void:
	text = text.to_upper()

func _on_pressed() -> void:
	click.play() 

func _on_mouse_entered() -> void:
	hover.play()
