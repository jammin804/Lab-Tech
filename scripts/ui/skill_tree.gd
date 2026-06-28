extends Panel


var skill_tree
var total_stat : PlayerStats

func _ready():
	load_skill_tree()

func _process(delta: float) -> void:
	print(total_stat.power)
	
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
	get_total_stats()

func add_stats(stat):
	total_stat.auto_fire = total_stat.auto_fire or stat.auto_fire
	total_stat.can_charge = total_stat.can_charge or stat.can_charge
	total_stat.charge_damage_multipler += stat.charge_damage_multipler
	
	total_stat.charge_rate += stat.charge_rate
	total_stat.battery_tanks += stat.battery_tanks
	total_stat.power += stat.power
	total_stat.damage_multipler += stat.damage_multipler
	total_stat.rapid += stat.rapid

func get_total_stats():
	total_stat = PlayerStats.new()
	for branch in get_children():
		for upgrade in branch.get_children():
			if upgrade.enabled:
				add_stats(upgrade.skill.stats)
	Persistence.bonus_stats = total_stat
				
