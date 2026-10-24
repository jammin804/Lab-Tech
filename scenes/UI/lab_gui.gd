class_name LabGui
extends Control

@onready var zone_label: Label = %ZoneLabel
@onready var enemies_killed_label: Label = %EnemiesKilledLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var enemies_required_label: Label = %EnemiesRequiredLabel
@onready var wave_label: Label = %WaveLabel

var waves: int = 0


func _ready() -> void:
	#Initalize the signals
	Events.lab_transition_finished.connect(_on_lab_transition_finished)
	pass

func initialize(zone_name, zone_req, prev_killed, total_killed, waves_to_complete) ->void:
	zone_label.text = zone_name
	enemies_required_label.text = str(zone_req)
	enemies_killed_label.text = str(prev_killed)

	progress_bar.max_value = zone_req
	progress_bar.value = prev_killed

	waves = waves_to_complete
	wave_label.text = "Waves Left: " + str(waves)

func update_progress_bar(start_value, enemies_defeated, ):

	if waves > 0:
		waves -= 1
	wave_label.text = str(waves)


	animate_value(start_value, enemies_defeated)

func _on_lab_transition_finished(enemies_defeated):
	#update_progress_bar(10)
	pass

func animate_value(start, target, tween_duration=1.0):
	progress_bar.value = start

	var tween : Tween
	tween = create_tween().set_trans(Tween.TRANS_SINE)

	tween.tween_property(progress_bar, "value", target, tween_duration)
	tween.set_parallel()
	tween.tween_method(_set_label_text, start, target, tween_duration)




func _set_label_text(num: int):
	enemies_killed_label.text = str(num)
