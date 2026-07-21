extends TalentFunctionality
class_name RapidChange

func action(talentIcon: TalentIcon):
	var bullet_count = talentIcon.talent_resource.stat_value

	PlayerManager.current_stats.rapid = bullet_count
	talentIcon.talent_resource.is_unlocked = true
