class_name ChargeProgressBar
extends HBoxContainer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var full_charge_border: TextureProgressBar = %FullChargeBorder


func _ready() -> void:
	Events.blaster_fully_charged.connect(_on_play_full_charged_anim)
	Events.charge_released.connect(_on_reset_full_charged_anim)

func _on_play_full_charged_anim() -> void:
	print("charging in Charge Progress Bar container")
	full_charge_border.show()
	animation_player.play("charging")


func _on_reset_full_charged_anim() -> void:
	full_charge_border.hide()
	animation_player.play("RESET")
	print(animation_player.current_animation)
