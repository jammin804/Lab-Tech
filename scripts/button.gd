extends Button

@export var click: AudioStreamPlayer

func _ready() -> void:
	text = text.to_upper()
	print(text.to_upper())

func _on_pressed() -> void:
	click.play() 
