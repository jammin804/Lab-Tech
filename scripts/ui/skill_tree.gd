extends Panel


var skill_tree

func _ready():
	load_skill_tree()

func set_skill_tree():
	skill_tree = []
	for each_branch in get_children():
		var branch = []
		for upgrade in each_branch.get_children():
			branch.append(upgrade.enabled)
		skill_tree.append(branch)
		
	SaveData.skill_tree = skill_tree
	SaveData.set_and_save()

func load_skill_tree():
	if SaveData.skill_tree == []:
		set_skill_tree()
	
	skill_tree = SaveData.skill_tree
	for branch in get_children():
		for upgrade in branch.get_children():
			upgrade.enabled = skill_tree[branch.get_index()][upgrade.get_index()]
