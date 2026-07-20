extends TalentFunctionality
class_name HealthChange

func action(talentIcon: TalentIcon):
	#print(talentIcon.talent_resource.talentName)
	#print(talentIcon.talent_resource.talentDescription)
	#print(talentIcon.talent_resource.BodyStat)
	var health = talentIcon.talent_resource.stat_value

	PlayerManager.current_stats.battery_tank_points += 100
	print(PlayerManager.current_stats.battery_tank_points)
	talentIcon.talent_resource.is_unlocked = true
