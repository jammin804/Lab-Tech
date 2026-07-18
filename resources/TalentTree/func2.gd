extends TalentFunctionality
class_name HealthChange

func action(talentIcon: TalentIcon):
	print(talentIcon.talent_resource.talentName)
	print(talentIcon.talent_resource.talentDescription)
	print(talentIcon.talent_resource.Stat)
	var health = talentIcon.talent_resource.statValue
	print(health)
	health += 100
	print(health)
