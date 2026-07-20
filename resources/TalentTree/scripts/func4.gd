extends TalentFunctionality
class_name TurretUnlock

func action(talentIcon: TalentIcon):
	talentIcon.talent_resource.is_unlocked = true
	if talentIcon.talent_resource.is_unlocked == true:
		PlayerManager.current_stats.auto_fire = true
