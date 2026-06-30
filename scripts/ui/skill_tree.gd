extends Control


var skill_tree
var total_stat : PlayerStats

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

func _process(delta: float) -> void:
	pass
	
func set_skill_tree():
	skill_tree = []
	for each_branch in get_child(1).get_children():
		var branch = []
		print(each_branch)
		for upgrade in each_branch.get_children():
			branch.append(upgrade.enabled)
		skill_tree.append(branch)
		
	SaveData.skill_tree = skill_tree
	SaveData.set_and_save()

func load_skill_tree():
	if SaveData.skill_tree == []:
		set_skill_tree()
	
	skill_tree = SaveData.skill_tree
	for branch in get_child(1).get_children():
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
	for branch in get_child(1).get_children():
		for upgrade in branch.get_children():
			if upgrade.enabled:
				add_stats(upgrade.skill.stats)
	Persistence.bonus_stats = total_stat
				


func _on_auto_fire_upgrade_pressed() -> void:
	if auto_fire_upgrade.enabled == true:
		print(auto_fire_upgrade.skill.stats.auto_fire)
		PlayerManager.current_stats.auto_fire = auto_fire_upgrade.skill.stats.auto_fire
		print(PlayerManager.current_stats.auto_fire)


func _on_charge_upgrade_pressed() -> void:
	if charge_upgrade.enabled == true:
		print(charge_upgrade.skill.stats.can_charge)
		PlayerManager.current_stats.can_charge = charge_upgrade.skill.stats.auto_fire
		print(PlayerManager.current_stats.can_charge)
		PlayerManager.current_stats.charge_damage_multipler = charge_upgrade.skill.stats.charge_damage_multipler


func _on_charge_upgrade_2_pressed() -> void:
	pass # Replace with function body.


func _on_charge_upgrade_3_pressed() -> void:
	pass # Replace with function body.
