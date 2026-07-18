class_name TalentIcon
extends PanelContainer

@export var talent_resource: TalentResource2 = null
@export var talent_functionality: TalentFunctionality = null

func _on_button_pressed() -> void:
	talent_functionality.action(self)
