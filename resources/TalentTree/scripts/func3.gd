extends TalentFunctionality
class_name ChargeUnlock

func action(talentIcon: TalentIcon):
	var multi = talentIcon.talent_resource.stat_value
	talentIcon.talent_resource.is_unlocked = true
	if talentIcon.talent_resource.is_unlocked == true:
		PlayerManager.current_stats.can_charge = true
		PlayerManager.current_stats.charge_damage_multipler = multi
