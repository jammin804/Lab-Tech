extends Panel


signal upgrade_selected
@export var upgrade_resource: UpgradeResource

var stat: int

@onready var upgrade_name_label: Label = %UpgradeNameLabel
@onready var upgrade_icon: TextureRect = %UpgradeIcon
@onready var upgrade_description_label: Label = %UpgradeDescriptionLabel


func _ready() -> void:
	upgrade_name_label.text = upgrade_resource.talentName
	upgrade_description_label.text = upgrade_resource.talentDescription
	upgrade_icon.texture = upgrade_resource.talent_icon
	stat = upgrade_resource.stat

func _apply_upgrade():

	PlayerManager.add_upgrade(upgrade_resource.upgrade, stat)

	upgrade_selected.emit()
