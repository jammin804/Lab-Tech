extends TextureButton
class_name Clicker

@onready var cta: Label = $"../CTA"
@onready var animation_player: AnimationPlayer = %AnimationPlayer



func _on_pressed() -> void:
	print("Pressed")
	if cta:
		cta.hide()
		cta.queue_free()
	animation_player.play("small_shake")
	
