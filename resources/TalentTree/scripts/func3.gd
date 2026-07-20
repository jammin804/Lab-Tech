extends TalentFunctionality
class_name ChargeUnlock

func action(talentIcon: TalentIcon):
	talentIcon.talent_resource.is_unlocked = true
	if talentIcon.talent_resource.is_unlocked == true:
		PlayerManager.current_stats.can_charge = true
