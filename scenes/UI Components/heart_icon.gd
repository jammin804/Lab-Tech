class_name HeartIcon
extends TextureRect


func play_animation() -> void:
	TweenFX.shake(self)
	TweenFX.explode(self)
	await TweenFX.explode(self).finished
	queue_free()
