class_name ResultScreenNew
extends Control

const GRADE_RANKS = ["F", "D", "C", "B", "A", "S"]

var player_won: bool = false #this will be change after a certain event is called
var cash_total: int = 0

@onready var success_label: Label = %SuccessLabel
@onready var enemy_label:Label = %EnemyDestoryedLabel
@onready var damage_done_label: Label = %DamageDoneLabel
@onready var damage_taken_label: Label = %DamageTakenLabel
@onready var money_collected_label: Label = %MoneyCollectedLabel
@onready var scraps_collect_label: Label = %ScrapsCollectLabel
@onready var cores_label: Label = %CoresLabel
@onready var letter_grade_label: Label = %LetterGradeLabel
@onready var return_btn: Button = %ReturnBtn
@onready var continue_btn: Button = %ContinueBtn
@onready var total_number_label: Label = %TotalNumberLabel



func setup(enemies:int, damage_done:int, damage_taken:int, money:int, scraps:int, cores:int, success: String, grade_index)->void:
	return_btn.hide()
	continue_btn.hide()

	player_won = (success.to_lower() == "victory" or success.to_lower() == "success")
	cash_total = money

	_set_enemy_label(0)
	_set_damage_done_label(0)
	_set_damage_taken_label(0)
	_set_money_label(0)
	_set_scraps_label(0)
	_set_cores_label(0)
	_set_grade_label(0)
	_set_total_label(0)

	_set_success_label(success)
	_animate_counters(enemies, damage_done, damage_taken, money, scraps, cores, grade_index, cash_total)

func _animate_counters(target_enemies:int, target_damage_done:int, target_damage_taken:int, target_money:int, target_scraps:int, target_cores:int, target_grade_index:int, target_cash_total: int):

	var tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)

	tween.set_parallel(true)

	tween.tween_interval(0.5)

	tween.tween_method(_set_enemy_label, 0, target_enemies, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	tween.tween_method(_set_damage_done_label, 0, target_damage_done, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	tween.tween_method(_set_damage_taken_label, 0, target_damage_taken, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	tween.tween_method(_set_money_label, 0, target_money, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	tween.tween_method(_set_scraps_label, 0, target_scraps, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	tween.tween_method(_set_cores_label, 0, target_cores, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	tween.tween_method(_set_grade_label, 0, target_grade_index, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	tween.chain()

	tween.tween_interval(1.0)
	tween.tween_method(_set_grade_label, 0, target_grade_index, 2.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_method(_set_total_label, 0, target_cash_total, 1.5).set_trans(Tween.TRANS_CUBIC). set_ease(Tween.EASE_OUT)

	tween.chain()
	tween.tween_callback(_reveal_buttons)


#region Setter Function Called by Tween
func _set_enemy_label(value: int) -> void:
	enemy_label.text = str(value)

func _set_damage_done_label(value: int) -> void:
	damage_done_label.text = str(value)

func _set_damage_taken_label(value: int) -> void:
	damage_taken_label.text = str(value)

func _set_money_label(value: int) -> void:
	money_collected_label.text = str(value)

func _set_scraps_label(value: int) -> void:
	scraps_collect_label.text = str(value)

func _set_cores_label(value: int) -> void:
	cores_label.text = str(value)

func _set_success_label(value: String) -> void:
	success_label.text = value

func _set_grade_label(array_index: int) -> void:
	var safe_index = clampi(array_index, 0, GRADE_RANKS.size() - 1)

	letter_grade_label.text = GRADE_RANKS[safe_index]

func _set_total_label(value: int) -> void:
	total_number_label.text = str(value)
	pass

#endregion

func _reveal_buttons() -> void:
	return_btn.show()

	if player_won:
		continue_btn.show()
	else:
		continue_btn.hide()

func _on_continue_pressed ()-> void:
	get_tree().paused = false
	queue_free()
	LevelTransition.change_scene_to("res://scenes/Levels/level_2.tscn")

func _on_return_pressed ()-> void:
	get_tree().paused = false
	queue_free()
	LevelTransition.change_scene_to("res://scenes/lab.tscn")


func _on_return_btn_pressed() -> void:
	print("clicking return")
	get_tree().paused = false
	queue_free()
	LevelTransition.change_scene_to("res://scenes/lab.tscn")
