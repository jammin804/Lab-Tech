extends CanvasLayer

@onready var battery_tanks: Label = $Stat/VBoxContainer2/VBoxContainer/BatteryTanks
@onready var battery_points: Label = $Stat/VBoxContainer2/VBoxContainer/BatteryPoints
@onready var power: Label = $Stat/VBoxContainer2/VBoxContainer/Power
@onready var shots_per: Label = $"Stat/VBoxContainer2/VBoxContainer/Shots Per"
@onready var charge_power: Label = $"Stat/VBoxContainer2/VBoxContainer/Charge Power"

@onready var charge_check: Label = $Stat/VBoxContainer2/VBoxContainer/ChargeCheck
@onready var limiter_check: Label = $Stat/VBoxContainer2/VBoxContainer/LimiterCheck
@onready var turret_check: Label = $Stat/VBoxContainer2/VBoxContainer/TurretCheck

@onready var money: Label = $Stat/VBoxContainer2/MoneyContainer/Money
@onready var scraps: Label = $Stat/VBoxContainer2/MoneyContainer/Scraps
@onready var core: Label = $Stat/VBoxContainer2/MoneyContainer/Core

var player_stats : PlayerManager
var player: PackedScene

func _ready() -> void:
	#player_stats = PlayerManager.duplicate()
	#print("This is the player stats: ", SkillManager.active_stats.auto_fire)
	Events.talent_icon_clicked.connect(_update_labels)
	_update_labels()



func _update_labels() -> void:
	battery_tanks.text = "Battery Tanks: " + str(PlayerManager.current_stats.battery_tanks)
	battery_points.text = "Battery Points: " + str(PlayerManager.current_stats.battery_tank_points)
	power.text = "Power: " + str(PlayerManager.current_stats.power)
	shots_per.text = "Shots Per: " + str(PlayerManager.current_stats.rapid)
	charge_power.text = "Charge Power: " + str(PlayerManager.current_stats.charge_damage_multipler * PlayerManager.current_stats.power)
	charge_check.text = "Charge Check: " + str(PlayerManager.current_stats.can_charge)
	limiter_check.text = "Limiter Check: " + str(PlayerManager.current_stats.super_click)
	turret_check.text = "Auto Turret Check: " + str(PlayerManager.current_stats.auto_fire)

	money.text = "Money " + str(SaveLoad.SaveFileData.money)
	scraps.text = "Scrap " + str(SaveLoad.SaveFileData,scraps)
	core.text = "Core " + str(SaveLoad.SaveFileData.core)




func _on_result_button_pressed() -> void:
	Events.show_result_screen.emit( 20, 18, 2, 20, 5, 1, "Failed", 3)


func _on_death_button_pressed() -> void:
	print("Call player die")
	#get_node()
	if player:
		player._die()
