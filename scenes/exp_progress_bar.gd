extends TextureProgressBar
class_name ExpBar

@export var player: Player
@onready var exp_numbers: Label = %ExpNumbers

func _ready() -> void:
	exp_numbers.text = str(player.current_exp) + "/ " + str(player.max_exp)
