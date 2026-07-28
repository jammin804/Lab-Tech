class_name TalentResource2
extends Resource

@export var talent_id: String
@export var prerequisites: Array[String] = []

@export var talent_icon: Texture2D
@export var is_unlocked:= false

@export var talentName : String
@export_multiline var talentDescription : String
@export var cost : int
@export_enum("Money", "Scrap", "Core") var currency_type: String = "Money"

@export var body_stat : BodyStat
@export var arms_stat : ArmStat
@export var stat_value : int
@export var stat_activated : bool = false

@export_enum("15", "45", "120","350") var cost_tiers: int = 15

enum BodyStat{BATTERY_TANKS, BATTERY_TANK_POINTS, FILTER}

enum ArmStat{POWER, RAPID, CHARGE, CHARGE_RATE, CHARGE_MULTIPLIER, STAGGER_DAMAGE}
