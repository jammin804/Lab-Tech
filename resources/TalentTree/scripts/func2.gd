extends TalentFunctionality
class_name HealthChange

var is_health_applied: bool = false

func action(talentIcon: TalentIcon):
	var health = talentIcon.talent_resource.stat_value

	if is_health_applied == false:
		PlayerManager.current_stats.battery_tank_points += health
		#print("New MAX HP: ", PlayerManager.current_stats.battery_tank_points)
		is_health_applied = true

	talentIcon.talent_resource.is_unlocked = true

	Events.max_health_upgraded.emit(PlayerManager.current_stats.battery_tank_points)
