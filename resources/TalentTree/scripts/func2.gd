extends TalentFunctionality
class_name HealthChange

func action(talentIcon: TalentIcon):
	var health = talentIcon.talent_resource.stat_value

	PlayerManager.current_stats.battery_tank_points = health
	print(PlayerManager.current_stats.battery_tank_points)
	talentIcon.talent_resource.is_unlocked = true
