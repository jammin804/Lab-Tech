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
	
	SaveData.branch_names = dynamic_names
	SaveData.skill_tree = skill_tree
	SaveData.set_and_save()
	
	SkillManager.calculate_unlocked_stats()

func load_skill_tree():
	if SaveData.skill_tree == []:
		set_skill_tree()
	
	skill_tree = SaveData.skill_tree
	for branch in get_child(1).get_children():
		for upgrade in branch.get_children():
			upgrade.enabled = skill_tree[branch.get_index()][upgrade.get_index()]


func on_upgrade_purchased() -> void:
	set_skill_tree()

func is_upgrade_unlocked(target_branch_name: String, tier_index: int) -> bool:
	for branch in get_child(1).get_children():
		if branch.name.to_snake_case() == target_branch_name:
			if tier_index < branch.get_child_count():
				return branch.get_child(tier_index).enabled
	return false

#func _on_auto_fire_upgrade_pressed() -> void:
	#if not auto_fire_upgrade.enabled:
		#auto_fire_upgrade.enabled = true
		#set_skill_tree()
#
#
#func _on_charge_upgrade_pressed() -> void:
	#if not charge_upgrade.enabled :
		#charge_upgrade.enabled = true
		#set_skill_tree()
#
#
#func _on_charge_upgrade_2_pressed() -> void:
	#if not charge_upgrade_2.enabled :
		#charge_upgrade_2.enabled = true
		#set_skill_tree()
#
#
#func _on_charge_upgrade_3_pressed() -> void:
	#if not charge_upgrade_3.enabled :
		#charge_upgrade_3.enabled = true
		#set_skill_tree()
#
#
#func _on_battery_upgrade_pressed() -> void:
	#if not battery_upgrade.enabled :
		#battery_upgrade.enabled = true
		#set_skill_tree()
#
#
#func _on_battery_upgrade_2_pressed() -> void:
	#if not battery_upgrade_2.enabled :
		#battery_upgrade_2.enabled = true
		#set_skill_tree()
#
#
#func _on_battery_upgrade_3_pressed() -> void:
	#if not battery_upgrade_3.enabled :
		#battery_upgrade_3.enabled = true
		#set_skill_tree()
#
#
#func _on_power_upgrade_pressed() -> void:
	#if not power_upgrade.enabled :
		#power_upgrade.enabled = true
		#set_skill_tree()
#
#
#func _on_power_upgrade_2_pressed() -> void:
	#if not power_upgrade_2.enabled :
		#power_upgrade_2.enabled = true
		#set_skill_tree()
#
#
#func _on_power_upgrade_3_pressed() -> void:
	#if not power_upgrade_3.enabled :
		#power_upgrade_3.enabled = true
		#set_skill_tree()
#
#
#func _on_rapid_upgrade_pressed() -> void:
	#if not rapid_upgrade.enabled :
		#rapid_upgrade.enabled = true
		#set_skill_tree()
#
#
#func _on_rapid_upgrade_2_pressed() -> void:
	#if not rapid_upgrade_2.enabled :
		#rapid_upgrade_2.enabled = true
		#set_skill_tree()
