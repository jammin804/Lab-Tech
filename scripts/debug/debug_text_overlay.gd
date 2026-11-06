extends Control

const VERSION_SETTING : String = "application/config/version"

@onready var fps_label: Label = %FpsLabel
@onready var version_info: Label = %VersionInfo

@onready var bullet_power_label: Label = %BulletPowerLabel
@onready var charge_rate_label: Label = %ChargeRateLabel
@onready var battery_drain_label: Label = %BatteryDrainLabel
@onready var charge_power_label: Label = %ChargePowerLabel


func _ready() -> void:
	_add_version_to_label()
	_add_player_info()

func _process(_delta: float) -> void:
	fps_label.set_text("FPS: " + str(Engine.get_frames_per_second()))

func _add_version_to_label() -> void:
	var version_str : String = ProjectSettings.get_setting(VERSION_SETTING)
	version_info.text += version_str


func _add_player_info():
	bullet_power_label.text += str(PlayerManager.current_stats.power)
	charge_rate_label.text += str(PlayerManager.current_stats.charge_rate)
