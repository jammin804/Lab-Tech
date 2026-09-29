class_name HeartBreak
extends CanvasLayer

@export var heart_icon : PackedScene
#@onready var heart_icon: TextureRect = %HeartIcon
@onready var heart_row_1: HBoxContainer = %HeartRow1
@onready var heart_row_2: HBoxContainer = %HeartRow2
@onready var retry_button: Button = %RetryButton
@onready var return_button: Button = %ReturnButton
@onready var double_down_button: Button = %DoubleDownButton

var hearts_array: Array[HeartIcon] = []
var is_double_down_unlocked : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_check_double_down_unlock()
	update_hearts()
	Events.win_condition_fail.connect(_on_win_condition_failed)
	double_down_button.pivot_offset = Vector2(102.0/2, 18.0/2)



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
	run_animations()

func _on_win_condition_failed() -> void:
	show()
	await get_tree().create_timer(1.0).timeout

	run_animations()


func run_animations():
	if hearts_array.size() > 0:
		hearts_array[-1].play_animation()
		hearts_array.pop_back()
	else:
		return

	await get_tree().create_timer(1.0).timeout
	retry_button.show()
	TweenFX.pop_in(retry_button)
	#await TweenFX.pop_in(retry_button).finished
	await get_tree().create_timer(1.0).timeout

	return_button.show()
	TweenFX.pop_in(return_button)
	await get_tree().create_timer(1.0).timeout


	if is_double_down_unlocked == true:
		double_down_button.show()
		TweenFX.glow_pulse(double_down_button)

func _on_return_button_pressed() -> void:
	LevelTransition.change_scene_to("res://scenes/lab.tscn")


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _check_double_down_unlock() -> void:
	is_double_down_unlocked = PlayerManager.current_stats.double_down


func _on_double_down_button_pressed() -> void:
	#double_down_button.pivot_offset = Vector2(102.0/2, 18.0/2)
	TweenFX.stop(double_down_button, TweenFX.Animations.GLOW_PULSE)
	TweenFX.glitch(double_down_button)
	await TweenFX.glitch(double_down_button).finished
	TweenFX.explode(double_down_button)
	print("Add damage to player but lose an upgrade")
