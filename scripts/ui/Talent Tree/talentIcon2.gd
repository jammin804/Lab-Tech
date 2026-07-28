class_name TalentIcon
extends PanelContainer

@export var talent_resource: TalentResource2 = null
@export var talent_functionality: TalentFunctionality = null

@export var lockColorBorder: Color
@export var unlockColorBorder : Color

@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	if not talent_resource and talent_functionality: return

	texture_rect.texture = talent_resource.talent_icon

	_set_style()

func _on_button_pressed() -> void:
	if talent_resource.is_unlocked == false:
		talent_functionality.action(self)
		Events.talent_icon_clicked.emit()
		_set_style()



func _set_style():
	var styleBox : StyleBoxFlat = self.get_theme_stylebox("panel").duplicate()

	if talent_resource.is_unlocked:
		styleBox.border_color = unlockColorBorder
	else:
		styleBox.border_color = lockColorBorder

	add_theme_stylebox_override("panel", styleBox)
