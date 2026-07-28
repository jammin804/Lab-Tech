class_name Skill_Tree
extends Control


var skill_tree
var total_stat : PlayerStats

@onready var super_click_upgrade: UpgradeButton = %SuperClick_Upgrade
@onready var auto_fire_upgrade: UpgradeButton = %AutoFire_Upgrade

@onready var charge_upgrade: UpgradeButton = %Charge_Upgrade
@onready var charge_upgrade_2: UpgradeButton = %Charge_Upgrade2
@onready var charge_upgrade_3: UpgradeButton = %Charge_Upgrade3

@onready var battery_upgrade: UpgradeButton = %Battery_Upgrade
@onready var battery_upgrade_2: UpgradeButton = %Battery_Upgrade2
@onready var battery_upgrade_3: UpgradeButton = %Battery_Upgrade3

@onready var power_upgrade: UpgradeButton = %Power_Upgrade
@onready var power_upgrade_2: UpgradeButton = %Power_Upgrade2
@onready var power_upgrade_3: UpgradeButton = %Power_Upgrade3

@onready var rapid_upgrade: UpgradeButton = %Rapid_Upgrade
@onready var rapid_upgrade_2: UpgradeButton = %Rapid_Upgrade2

func _ready():
	load_skill_tree()

func set_skill_tree():
	skill_tree = []
	var dynamic_names = []

	for each_branch in get_child(1).get_children():
		var clean_name = each_branch.name.to_snake_case()
		dynamic_names.append(clean_name)

		var branch = []
		for upgrade in each_branch.get_children():
			branch.append(upgrade.enabled)
			print(branch)
		skill_tree.append(branch)

	SaveData.save_data["branch_names"] = dynamic_names
	SaveData.save_data["skill_tree"] = skill_tree
	SaveData._save()

	SkillManager.calculate_unlocked_stats()

func load_skill_tree():
	if SaveData.save_data["skill_tree"].is_empty():
		set_skill_tree()

	skill_tree = SaveData.save_data["skill_tree"]

	if skill_tree.is_empty():
		return

	for branch in get_child(1).get_children():
		for upgrade in branch.get_children():
			if branch.get_index() < skill_tree.size() and upgrade.get_index() < skill_tree[branch.get_index()].size():
				upgrade.enabled = skill_tree[branch.get_index()][upgrade.get_index()]


func on_upgrade_purchased() -> void:
	set_skill_tree()

func is_upgrade_unlocked(target_branch_name: String, tier_index: int) -> bool:
	for branch in get_child(1).get_children():
		if branch.name.to_snake_case() == target_branch_name:
			if tier_index < branch.get_child_count():
				return branch.get_child(tier_index).enabled
	return false
