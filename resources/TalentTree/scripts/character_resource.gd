class_name CharacterResource
extends Resource

@export var level := 1
@export var health := 100
@export var attack := 30

@export var talents: Array[TalentResource2]

func get_character_stats():
	for talent:TalentResource2 in talents:
		match talent.body_stat:
			talent.BodyStat.BATTERY_TANK_POINTS: health += talent.stat_value
		match talent.arms_stat:
			talent.ArmStat.POWER: attack += talent.stat_value

	return {
		"health": health,
		"attack": attack
	}
