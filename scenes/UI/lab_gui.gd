class_name LabGui
extends Control

@onready var zone_label: Label = %ZoneLabel
@onready var enemies_killed_label: Label = %EnemiesKilledLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var enemies_required_label: Label = %EnemiesRequiredLabel
@onready var wave_label: Label = %WaveLabel

var waves: int = 0
#var start
var prev_killed
var new_killed


func _ready() -> void:
	#Initalize the signals
	prev_killed = Globals.previous_killed
	new_killed = Globals.enemies_killed
	pass

func initialize(zone_name, zone_req, waves_to_complete) ->void:
	zone_label.text = zone_name
	enemies_required_label.text = str(zone_req)
	enemies_killed_label.text = str(prev_killed)

	progress_bar.max_value = zone_req
	progress_bar.value = prev_killed

	waves = waves_to_complete
	wave_label.text = "Waves Left: " + str(waves)

func update_progress_bar(prev_enemies, enemies_defeated):
	if waves > 0:
		waves -= 1
	wave_label.text = str(waves)


	animate_value(prev_enemies, enemies_defeated)
	#if abs(progress_bar.max_value - progress_bar.value) - 0.01 or progress_bar.value == progress_bar.max_value:
		#progress_bar.value = 0

func animate_value(start, target, tween_duration=1.0):
	var tween : Tween
	tween = create_tween().set_trans(Tween.TRANS_SINE)

	tween.tween_property(progress_bar, "value", target, tween_duration)
	tween.set_parallel()
	tween.tween_method(_set_label_text, start, target, tween_duration)
	await tween.finished
	print("hello ", target)

	if abs(progress_bar.max_value - progress_bar.value) - 0.01 or target == progress_bar.max_value:
		progress_bar.value = 0
	#if target == progress_bar.max_value:
		#print("Can play sfx to indicate level transition zone info")
		#print("emit level up")
		#progress_bar.value = 0



func _set_label_text(num: int):
	enemies_killed_label.text = str(num)
