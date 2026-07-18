extends TalentFunctionality
class_name ChargeChange

func action(talentIcon: TalentIcon):
	print(talentIcon.talent_resource.Stat.CHARGE_ATTACK)
	print(talentIcon.talent_resource.talentName)
	print(talentIcon.talent_resource.talentDescription)
	print(talentIcon.talent_resource.Stat)
