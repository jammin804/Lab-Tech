extends TalentFunctionality
class_name DamageUpgrade

func action(talentIcon: TalentIcon):
	var damage = talentIcon.talent_resource.stat_value

	PlayerManager.current_stats.power = damage * PlayerManager.current_stats.power
	talentIcon.talent_resource.is_unlocked = true
