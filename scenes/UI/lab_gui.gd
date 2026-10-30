class_name LabGui
extends Control


signal on_maxed_meter

@onready var zone_label: Label = %ZoneLabel
@onready var enemies_killed_label: Label = %EnemiesKilledLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var enemies_required_label: Label = %EnemiesRequiredLabel
@onready var wave_label: Label = %WaveLabel

var waves: int = 0
#var start
var prev_killed: int
var new_killed: int
var kills_to_next: int
var zone_num: int = 0
var zone_can_change: bool = false


func _ready() -> void:
	#Initalize the signals
	prev_killed = Globals.previous_killed
	new_killed = Globals.enemies_killed


func initialize(zone_name, zone_req, waves_to_complete) ->void:
	kills_to_next = zone_req

	zone_label.text = zone_name
	enemies_required_label.text = str(kills_to_next)
	enemies_killed_label.text = str(prev_killed)

	progress_bar.max_value = kills_to_next
	progress_bar.value = prev_killed

	waves = waves_to_complete
	wave_label.text = "Waves Left: " + str(waves)

func update_progress_bar(prev_enemies, enemies_defeated):
	if waves == 0:
		print("Game Over")

	if waves > 0:
		waves -= 1
	wave_label.text = str(waves)

	#xp_to_next(enemies_defeated)
	animate_value(prev_enemies, enemies_defeated)
	if abs(progress_bar.max_value - progress_bar.value) < 0.01 or enemies_defeated == progress_bar.max_value:
		progress_bar.value = 0

func animate_value(start, target, tween_duration=1.0):
	var tween : Tween
	tween = create_tween().set_trans(Tween.TRANS_SINE)

	tween.tween_property(progress_bar, "value", target, tween_duration)
	tween.set_parallel()
	tween.tween_method(_set_label_text, start, target, tween_duration)
	await tween.finished
	_check_bar_progress(target)




func _set_label_text(num: int):
	enemies_killed_label.text = str(num)


func xp_to_next(enemies_defeated):
	progress_bar.max_value = kills_to_next
	progress_bar.value = enemies_defeated



func _check_bar_progress(amount: int) -> void:
	if amount >= progress_bar.max_value:
		var tween : Tween
		print("Start the animation again")
		progress_bar.value = 0

		tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(progress_bar, "value", amount-progress_bar.max_value, 1.0)
		#TODO FOR 10/30: Call level up function to increment the zone index or show zone complete screen
		#TODO FOR 10/30: Move up to next zone/level and the information with it
