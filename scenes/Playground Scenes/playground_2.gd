extends Node2D

@onready var defeated_label: Label = %DefeatedLabel
@onready var last_defeated_label: Label = %LastDefeatedLabel

var start


func _ready() -> void:
	_update_label()
	_set_prev_text(Globals.prev_enemies_killed)




func _on_button_pressed() -> void:
	#get_tree().reload_current_scene()
	LevelTransition.change_scene_to("res://scenes/lab.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			Globals.enemies_killed += 10
			_update_label()
			await get_tree().create_timer(1.0).timeout
			_animate_num(Globals.enemies_killed)


func _update_label() -> void:
	defeated_label.text = "Current Enemies Killed: " + str(Globals.enemies_killed)


func _animate_num(target) -> void:
	var tween: Tween
	tween = create_tween()
	start = 0
	print("Starting Value is ", start)
	#target = curr_enemy

	tween.tween_method(_set_prev_text, start, target, 1.0)

func _set_prev_text(num):
	last_defeated_label.text = "Previous Enemies Killed: " + "%d" % num
