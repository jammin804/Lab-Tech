class_name LabGui
extends Control


#signal on_maxed_meter
signal zone_completed
signal game_over

@onready var zone_label: Label = %ZoneLabel
@onready var enemies_killed_label: Label = %EnemiesKilledLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var enemies_required_label: Label = %EnemiesRequiredLabel
@onready var wave_label: Label = %WaveLabel

var wave: int
var prev_waves: int
var prev_killed: int
var new_killed: int
var kills_to_next: int
var zone_num: int = 0
var zone_can_change: bool = false


func _ready() -> void:
	#Initalize the signals
	prev_killed = Globals.previous_killed
	new_killed = Globals.enemies_killed


func initialize(zone_name, zone_req, prev_wave, is_new_zone) ->void:
	kills_to_next = zone_req
	zone_label.text = zone_name
	enemies_required_label.text = str(kills_to_next)
	enemies_killed_label.text = str(prev_killed)

	progress_bar.max_value = kills_to_next
	if is_new_zone:
		progress_bar.value = 0
	else:
		progress_bar.value = prev_killed


	wave_label.text = "Waves Left: " + str(prev_wave)


func update_progress_bar(prev_enemies, enemies_defeated):
	animate_value(prev_enemies, enemies_defeated)


func animate_value(start, target, tween_duration=1.0):
	var tween : Tween
	tween = create_tween().set_trans(Tween.TRANS_SINE)

	tween.tween_property(progress_bar, "value", target, tween_duration)
	tween.set_parallel()
	tween.tween_method(_set_label_text, start, target, tween_duration)
	await tween.finished
	_check_bar_progress(target)
	#TODO [POLISHING] 11/13 Have the bar make sfx when its is progressing



func _set_label_text(num: int):
	enemies_killed_label.text = str(num)


func xp_to_next(enemies_defeated):
	progress_bar.max_value = kills_to_next
	progress_bar.value = enemies_defeated


func _check_bar_progress(amount: int) -> void:
	if amount >= progress_bar.max_value:
		zone_completed.emit()


func update_wave_label(waves):

	if waves == 0:
		#TODO 11/11 Add Game Over condition (to be tested)
		print("Game Over")

	if waves > 0:
		Globals.current_wave -= 1

	wave_label.text = "Waves Left: " + str(Globals.current_wave)
	_check_wave_num()


func _check_wave_num():
	if Globals.current_wave < 1:
		print("GAMEOVER from Lab_Gui")
		game_over.emit()
