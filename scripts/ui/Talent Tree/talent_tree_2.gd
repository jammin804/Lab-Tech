extends Control
class_name TalentTree2

@export var active_talents:Array = []

func _ready() -> void:
	Events.talent_icon_clicked.connect(_add_to_active_talents)
	_add_to_active_talents()

func _add_to_active_talents() -> void:
	var number_of_talents : int = 0
	for talent_node in get_tree().get_nodes_in_group("talents"):
		number_of_talents += 1
		if talent_node.talent_resource.is_unlocked == true:
			active_talents.append(talent_node.talent_resource)
			number_of_talents -=1
			print(active_talents)
		else:
			print(number_of_talents, " are not active")
			#print(talent_node.talent_resource.is_unlocked)
			pass
