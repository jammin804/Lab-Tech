extends TextureProgressBar
class_name ExpBar

@export var player: Player
@onready var exp_numbers: Label = %ExpNumbers

func _ready() -> void:
	update_exp_bar()

func update_exp_bar() -> void:
	value = player.current_exp * 100 / player.max_exp	
	exp_numbers.text = str(player.current_exp) + "/ " + str(player.max_exp)
