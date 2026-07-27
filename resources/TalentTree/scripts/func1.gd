extends TalentFunctionality
class_name LimiterChange

func action(talentIcon: TalentIcon):
	talentIcon.talent_resource.is_unlocked = true
	if talentIcon.talent_resource.is_unlocked == true:
		PlayerManager.current_stats.super_click = true
