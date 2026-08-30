extends Sprite2D

var rng = RandomNumberGenerator.new()

var my_array = [randi_range(1, 3), randi_range(4, 6), randi_range(15, 22)]
var weights = PackedFloat32Array([0.66, 0.3, 0.04])

func _on_button_pressed() -> void:
	print(my_array[rng.rand_weighted(weights)])
