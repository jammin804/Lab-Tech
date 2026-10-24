extends TalentFunctionality
class_name DamageUpgrade

var damage
var is_damage_applied: bool = false


func action(talentIcon: TalentIcon):
	damage = talentIcon.talent_resource.stat_value

	if is_damage_applied == false:
		PlayerManager.current_stats.power = damage * PlayerManager.current_stats.power
		is_damage_applied = true

	talentIcon.talent_resource.is_unlocked = true
