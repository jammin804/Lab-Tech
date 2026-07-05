extends Node2D

var money = 1000
var skill_tree = []
var branch_names =[]

const PATH = "user://player_data.cfg"
@onready var config = ConfigFile.new()


func _ready() -> void:
	load_data()

func save_data():
	config.save(PATH)
	
func set_data():
	config.set_value("Player", "money", money)
	for i in range(skill_tree.size()):
		print("How large is the skill tree" + str(range(skill_tree.size())))
		if i < branch_names.size():
			config.set_value("Skill_Tree", branch_names[i], skill_tree[i])
	
func set_and_save():
	set_data()
	save_data()
	
func load_data():
	if config.load(PATH) != OK:
		set_and_save()
		return
		
	money = config.get_value("Player", "money", 1000)
	
	skill_tree.clear()
	branch_names.clear()
	
	if config.has_section("Skill_Tree"):
		for key in config.get_section_keys("Skill_Tree"):
			branch_names.append(key)
			skill_tree.append(config.get_value("Skill_Tree", key, []))
	
	#for branch_name in BRANCH_NAMES:
		#var default_branch = [false]
		#var loaded_branch = config.get_value("Skill_Tree", branch_name, default_branch)
		#skill_tree.append(loaded_branch)
		
#		= config.get_value("Player", "skill_tree", [])
