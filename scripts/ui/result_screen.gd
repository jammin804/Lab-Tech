class_name Result_Screen
extends Control

@onready var money_label: Label = $TextureRect/MarginContainer/VBoxContainer/MoneyContainer/Score
@onready var scrap_label: Label = $TextureRect/MarginContainer/VBoxContainer/ScrapContainer/Score
@onready var total_score_label: Label = $TextureRect/MarginContainer/VBoxContainer/TotalScoreCotnainer/Score
@onready var star_rect  = "TextureRect/MarginContainer/VBoxContainer/StarContainer/StarRect"

var money = 30
var moneyMax = 40
var scrap = 3
var scrapMax = 3
var stars = [true, false, true]
var starsMax = 3
var starCount = len(stars.filter(
	func(boolean): return boolean != false
))
var totalMaxScore = scrap * 10 + starsMax * 10 + moneyMax
var totalScore = scrap * 10  + starCount * 10 + money
var scorePercent = totalScore * 100 / totalMaxScore

func _ready():
	_set_result_screen()
	
func _set_result_screen():
	await _label_animation(money_label, money, moneyMax, 0.025)
	await _label_animation(scrap_label, scrap, scrapMax, 0.2)
	await _star_animation(stars)
	
	await _label_animation(total_score_label, scorePercent, -1, 0.025)

func _label_animation(label: Label, count: int, max: int, duration: float) -> void:
	for i in count + 1:
		label.text = str(i)
		if max >= 0: label.text += "/" + str(max)
		else: label.text += "%"
		await get_tree().create_timer(duration).timeout

func _star_animation(stars):
	for i in len(stars):
		if stars[i]:
			var nodePath = star_rect + str(i + 1)
			var starRectNode = get_node(nodePath)
			print(get_node(nodePath))
			starRectNode.set_modulate(Color(1,1,1))
		await get_tree().create_timer(0.2).timeout
		
		
