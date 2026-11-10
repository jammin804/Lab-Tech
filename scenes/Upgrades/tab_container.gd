extends TabContainer

@export var power: Label
@export var shots_per: Label
@export var charge_power: Label
@export var cores_label: Label
@export var confirm_btn: Button

var cores: int = 0
var money: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cores = SaveLoad.SaveFileData.core
	cores_label.text = str(cores)

	power.text +=  " " + str(PlayerManager.current_stats.power)
	shots_per.text += " " + str(PlayerManager.current_stats.fire_rate_multipler)
	charge_power.text += " " + str(PlayerManager.current_stats.charge_damage_multipler)

	check_have_cores()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func check_have_cores():
	#TODO 11/13 need to set it to allow increase
	pass


func _on_dmg_plus_button_pressed() -> void:
	if cores > 0:
		cores -= 1
		update_labels()


func update_labels():
	cores_label.text = str(cores)
