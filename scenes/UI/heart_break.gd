class_name HeartBreak
extends CanvasLayer

@export var heart_icon : PackedScene
#@onready var heart_icon: TextureRect = %HeartIcon
@onready var heart_row_1: HBoxContainer = %HeartRow1
@onready var heart_row_2: HBoxContainer = %HeartRow2

var hearts_array: Array[HeartIcon] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_hearts()
	Events.win_condition_fail.connect(_on_win_condition_failed)



func update_hearts() -> void:
	#var heart_1_row = heart_row_1.get_childern()
	for i in range(Globals.player_lives):
		var heart = heart_icon.instantiate()

		if Globals.player_lives < 6:
			heart_row_2.hide()
		else:
			heart_row_2.show()

		if Globals.player_lives < 6:
			heart_row_1.add_child(heart)
		else:
			heart_row_2.add_child(heart)


		hearts_array.append(heart)


func _on_break_heart_pressed() -> void:
	if hearts_array.size() > 0:
		hearts_array[-1].play_animation()
		hearts_array.pop_back()
	else:
		return


func _on_win_condition_failed() -> void:
	show()
	await get_tree().create_timer(1.0).timeout

	if hearts_array.size() > 0:
		hearts_array[-1].play_animation()
		hearts_array.pop_back()
	else:
		return
