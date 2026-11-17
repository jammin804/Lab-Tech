extends TabContainer

@export var power: Label
@export var shots_per: Label
@export var charge_power: Label
@export var cores_label: Label
@export var confirm_btn: Button

#upgrade level info
var max_upgrade_lvl: int = 3

#currency
var cores: int = 0
var starting_cores: int = 0
var money: int = 0

#stats
var damage: int = 0
var dmg_prev: int = 0
var dmg_cost: int = 0
var atk_speed: int = 0
var charge_damage: float = 0.0
var damage_percentage: float = 0.0
var additonal_enemy: int = 0

var upgrade_level: Dictionary = {
	"dmg_lvl": 1,
	"atk_spd_lvl": 1,
	"charge_dmg_lvl": 1,
	"add_enemy_lvl": 1
}


@onready var dmg_label: Label = %DMGLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#TODO 11/17 Remove the 99 and have it pull for the SaveFileData
	cores = 99#SaveLoad.SaveFileData.core
	starting_cores = cores
	cores_label.text = str(cores)

	power.text +=  " " + str(PlayerManager.current_stats.power)
	shots_per.text += " " + str(PlayerManager.current_stats.fire_rate_multipler)
	charge_power.text += " " + str(PlayerManager.current_stats.charge_damage_multipler)


	check_have_cores()


func check_have_cores():
	#TODO 11/13 need to set it to allow increase...[I forgot what i was trying to do here]
	pass




func update_labels():
	cores_label.text = str(cores)

	#For Damage Stat
	dmg_label.text = "DMG UP v" + str(upgrade_level["dmg_lvl"])
	power.text =  "Power: " + str(PlayerManager.current_stats.power + damage)


func _add_core(amount: int):
	#POLISH Think about how to exponetially increase the amound depending on what button was pressed
	cores += amount
	update_labels()


func _remove_core(amount: int):
	cores -= amount
	update_labels()


#region add enemy btns
func _on_minus_enemy_btn_pressed() -> void:
	if cores < starting_cores and upgrade_level["add_enemy_lvl"] > 1:
		upgrade_level["add_enemy_lvl"] -=1
		_add_core(3)

func _on_add_enemy_button_pressed() -> void:
	if cores > 0 and upgrade_level["add_enemy_lvl"] < 4:
		if cores > 3:
			upgrade_level["add_enemy_lvl"] +=1
			_remove_core(3)
#endregion

#region dmg btns
func _on_dmg_plus_button_pressed() -> void:
	if cores > 0 and upgrade_level["dmg_lvl"] < 3:
		#_check_cost()
		damage += 5
		upgrade_level["dmg_lvl"] += 1
		#update_labels()
		_remove_core(1)


func _on_dmg_minus_button_pressed() -> void:
	if cores < starting_cores and upgrade_level["dmg_lvl"] > 1:
		#_check_cost()
		upgrade_level["dmg_lvl"] -= 1
		damage -= 5
		_add_core(1)
		#upgrade_level["dmg_lvl"] += 1
		#update_labels()
#endregion

func _on_confirm_btn_pressed() -> void:
	PlayerManager.add_upgrade(PlayerManager.current_stats.upgrades.ADD_DAMAGE, damage)
	Globals.additional_enemies_to_level += additonal_enemy
	if max_upgrade_lvl == upgrade_level["dmg_lvl"]:
		%DMGMinusButton.disabled = true
		%DMGPlusButton.disabled = true
	if max_upgrade_lvl == upgrade_level["add_enemy_lvl"]:
		%MinusEnemyBtn.disabled = true
		%AddEnemyButton.disabled = true
	#TODO 11/17 Save the data including the amound of money and cores used
