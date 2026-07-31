class_name Result_Screen
extends Control

@onready var money_label: Label = $TextureRect/MarginContainer/VBoxContainer/MoneyContainer/Score
@onready var scrap_label: Label = $TextureRect/MarginContainer/VBoxContainer/ScrapContainer/Score
@onready var total_score_label: Label = $TextureRect/MarginContainer/VBoxContainer/TotalScoreCotnainer/Score
@onready var star_rect  = "TextureRect/MarginContainer/VBoxContainer/StarContainer/StarRect"

@onready var continue_button: Button = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/ContinueButton
@onready var lab_button: Button = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/LabButton

var lab_scene: String = "res://scenes/lab.tscn"

var money = 30
var moneyMax = 40
var scrap = 3
var scrapMax = 3
var stars = [false, false, false]
var starsMax = 3
var starCount = len(stars.filter(
	func(boolean): return boolean != false
))
var totalMaxScore = scrap * 10 + starsMax * 10 + moneyMax
var totalScore = scrap * 10  + starCount * 10 + money
#var scorePercent = totalScore * 100 / totalMaxScore

func _ready():
	#_set_result_screen()
	Events.show_result_screen.connect(_set_result_screen)
	Events.level_complete.connect(_update_level)

func _set_result_screen(money_gained: int, scrap_gained: int):
	#print(money_gained)
	if self.visible == false:
		self.visible = true

	await _label_animation(money_label, money_gained, moneyMax, 0.025)
	await _label_animation(scrap_label, scrap_gained, scrapMax, 0.2)
	await _star_animation(stars)

	#await _label_animation(total_score_label, scorePercent, -1, 0.025)
	await _button_animation(lab_button)
	await _button_animation(continue_button)


func _label_animation(label: Label, count: int, maxAmount: int, duration: float) -> void:
	for i in count + 1:
		label.text = str(i)
		if maxAmount >= 0: label.text
		else: label.text += "%"
		await get_tree().create_timer(duration).timeout

func _star_animation(star: Array):
	for i in len(star):
		if star[i]:
			var nodePath = star_rect + str(i + 1)
			var starRectNode = get_node(nodePath)
			#print(get_node(nodePath))
			starRectNode.set_modulate(Color(1,1,1))
		await get_tree().create_timer(0.2).timeout


func _button_animation(button: Button) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(button, "modulate:a", 1.0, .5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(button, "offset_transform_scale", Vector2(1.0,1.0), .5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	await get_tree().create_timer(.8).timeout

func _update_level(level: int) -> void:
	print(level)

func _on_lab_button_pressed() -> void:
	print("Lab buttone pressed in result screen")
	LevelTransition.change_scene_to(lab_scene)


func _on_continue_button_pressed() -> void:
	LevelTransition._on_change_level()
