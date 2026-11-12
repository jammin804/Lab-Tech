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
var atk_speed: int = 0
var charge_damage: float = 0.0
var damage_percentage: float = 0.0

var upgrade_level: Dictionary = {
	"dmg_lvl": 1,
	"atk_spd_lvl": 1,
	"charge_dmg_lvl": 1,
}


@onready var dmg_label: Label = %DMGLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cores = SaveLoad.SaveFileData.core
	starting_cores = cores
	cores_label.text = str(cores)

	power.text +=  " " + str(PlayerManager.current_stats.power)
	shots_per.text += " " + str(PlayerManager.current_stats.fire_rate_multipler)
	charge_power.text += " " + str(PlayerManager.current_stats.charge_damage_multipler)

	check_have_cores()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func check_have_cores():
	#TODO 11/13 need to set it to allow increase
	pass


func _on_dmg_plus_button_pressed() -> void:
	if cores > 0 and upgrade_level["dmg_lvl"] < 3:
		cores -= 1
		damage += 5
		upgrade_level["dmg_lvl"] += 1
		print("After plus ", cores)
		update_labels()

func _on_dmg_minus_button_pressed() -> void:
	if cores < starting_cores and upgrade_level["dmg_lvl"] > 1:
		cores += 1
		upgrade_level["dmg_lvl"] -= 1
		print("After minus ", cores)

		damage -= 5
		#upgrade_level["dmg_lvl"] += 1
		update_labels()

func update_labels():
	cores_label.text = str(cores)

	#For Damage Stat
	dmg_label.text = "DMG UP v" + str(upgrade_level["dmg_lvl"])
	power.text =  "Power: " + str(PlayerManager.current_stats.power + damage)


func _on_confirm_btn_pressed() -> void:
	PlayerManager.add_upgrade(PlayerManager.current_stats.upgrades.ADD_DAMAGE, damage)
	if max_upgrade_lvl == upgrade_level["dmg_lvl"]:
		%DMGMinusButton.disabled = true
		%DMGPlusButton.disabled = true
	#LevelTransition.change_scene_to("res://scenes/Levels/level_1.tscn")
