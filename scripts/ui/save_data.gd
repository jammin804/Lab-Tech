extends Node2D

var money = 10000
var skill_tree = []

const PATH = "user://player_data.cfg"
@onready var config = ConfigFile.new()

func _ready() -> void:
	load_data()

func save_data():
	config.save(PATH)
	
func set_data():
	config.set_value("Player", "money", money)
	config.set_value("Player", "skill_tree", skill_tree)
	
func set_and_save():
	set_data()
	save_data()
	
func load_data():
	if config.load(PATH) != OK:
		set_and_save()
		
	money = config.get_value("Player", "money", 10000)
	skill_tree = config.get_value("Player", "skill_tree", [])
