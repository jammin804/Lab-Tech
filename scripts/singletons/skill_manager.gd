extends Node

@export var super_click_branch: Array[Resource]
@export var auto_fire_branch: Array[Resource]
@export var charge_branch: Array[Resource]
@export var battery_branch: Array[Resource]
@export var power_branch: Array[Resource]
@export var rapid_branch: Array[Resource]

var base_stats : PlayerStats = load("res://resources/PlayerData/starting_stats.tres")
var active_stats : PlayerStats = PlayerStats.new()

func _ready() -> void:
	calculate_unlocked_stats()

func calculate_unlocked_stats() -> void:
	var bonus = Persistence.bonus_stats
	print(bonus.battery_tanks)
	# Reset active_stats to match base_stats
	active_stats.power = base_stats.power + bonus.power
	active_stats.battery_tanks = base_stats.battery_tanks + bonus.battery_tanks
	active_stats.battery_tank_points = base_stats.battery_tank_points + bonus.battery_tank_points
	active_stats.rapid = base_stats.rapid + bonus.rapid
	active_stats.charge_rate = base_stats.charge_rate + bonus.charge_rate
	
	#Booleans: If base OR bonus has it, it is unlocked
	active_stats.can_charge = base_stats.can_charge or bonus.can_charge
	active_stats.auto_fire = base_stats.auto_fire or bonus.auto_fire
	active_stats.super_click = base_stats.super_click or bonus.super_click
	
	
	
	var total_stat = PlayerStats.new()
	var skill_tree = SaveData.skill_tree
	
	if skill_tree.is_empty():
		return
	
	#Super Click
	if skill_tree.size() > 0:
		for i in range(skill_tree[0].size()):
			if skill_tree[0][i] == true:
				add_stats(total_stat, super_click_branch[i].stats)
	
	#Auto Fire
	if skill_tree.size() > 1:
		for i in range(skill_tree[1].size()):
			if skill_tree[1][i] == true:
				add_stats(total_stat, auto_fire_branch[i].stats)
	
	#Charge
	if skill_tree.size() > 2:
		for i in range(skill_tree[2].size()):
			if skill_tree[2][i] == true:
				add_stats(total_stat, charge_branch[i].stats)
				
	#Battery
	if skill_tree.size() > 3:
		for i in range(skill_tree[3].size()):
			if skill_tree[3][i] == true:
				add_stats(total_stat, battery_branch[i].stats)
				
	#Power
	if skill_tree.size() > 4:
		for i in range(skill_tree[4].size()):
			if skill_tree[4][i] == true:
				add_stats(total_stat, power_branch[i].stats)
				
	#Rapid
	if skill_tree.size() > 5:
		for i in range(skill_tree[5].size()):
			if skill_tree[5][i] == true:
				add_stats(total_stat, rapid_branch[i].stats)
	
	Persistence.bonus_stats = total_stat
	#print(total_stat.can_charge)
				
func add_stats(total: PlayerStats, stat: PlayerStats) -> void:
	total.super_click = total.super_click or stat.super_click
	total.auto_fire = total.auto_fire or stat.auto_fire
	total.can_charge = total.can_charge or stat.can_charge
	total.charge_damage_multipler += stat.charge_damage_multipler
	
	total.charge_rate += stat.charge_rate
	total.battery_tanks += stat.battery_tanks
	total.power += stat.power
	total.damage_multipler += stat.damage_multipler
	total.rapid += stat.rapid
