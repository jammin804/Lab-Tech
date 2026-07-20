extends TalentFunctionality
class_name LimiterChange

func action(talentIcon: TalentIcon):
	#print(PlayerManager.current_stats.super_click)
	talentIcon.talent_resource.is_unlocked = true
	#print("The icon is unlocked", talentIcon.talent_resource.is_unlocked)
	if talentIcon.talent_resource.is_unlocked == true:
		PlayerManager.current_stats.super_click = true
