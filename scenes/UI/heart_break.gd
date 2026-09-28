class_name HeartBreak
extends CanvasLayer

@export var heart_icon = preload("res://scenes/UI Components/heart_icon.tscn")
#@onready var heart_icon: TextureRect = %HeartIcon
@onready var heart_row_1: HBoxContainer = %HeartRow1
@onready var heart_row_2: HBoxContainer = %HeartRow2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_hearts()


func update_hearts() -> void:
	#var heart_1_row = heart_row_1.get_childern()
	for i in range(Globals.player_lives):
		var heart = heart_icon.instantiate()

		heart_row_1.add_child(heart)
		if Globals.player_lives < 6:
			heart_row_2.hide()
		else:
			heart_row_2.show()

		#heart_row_1.add_child()
