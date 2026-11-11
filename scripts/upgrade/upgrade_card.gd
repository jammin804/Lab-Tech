class_name UpgradeCard
extends Panel


signal upgrade_selected
@export var upgrade_resource: UpgradeResource

var stat: float
var animation_tween: Tween
var hover_scale: Vector2 = Vector2(1.1, 1.1)
var hover_animation_length: float = 0.1
var un_hover_animation_length: float = 0.1

@onready var upgrade_name_label: Label = %UpgradeNameLabel
@onready var upgrade_icon: TextureRect = %UpgradeIcon
@onready var upgrade_description_label: Label = %UpgradeDescriptionLabel


func _ready() -> void:
	upgrade_name_label.text = upgrade_resource.upgrade_name
	upgrade_description_label.text = upgrade_resource.upgrade_description
	upgrade_icon.texture = upgrade_resource.icon
	stat = upgrade_resource.stat

	pivot_offset_ratio = Vector2.ONE / 2.0

func apply_upgrade():

	PlayerManager.add_upgrade(upgrade_resource.upgrade, upgrade_resource.stat)

	upgrade_selected.emit()


func _on_mouse_entered() -> void:
	if animation_tween:
		animation_tween.kill()

	animation_tween = create_tween().set_trans(Tween.TRANS_SINE)
	animation_tween.tween_property(self, "scale", hover_scale, hover_animation_length)

func _on_mouse_exited() -> void:
	if animation_tween:
		animation_tween.kill()

	animation_tween = create_tween().set_trans(Tween.TRANS_SINE)
	animation_tween.tween_property(self, "scale", Vector2.ONE, un_hover_animation_length)
