extends Node2D

@onready var dmg_btn: Button = $TestBtnContainers/DmgBtn
@onready var upgrade_max_health_btn: Button = $TestBtnContainers/UpgradeMaxHealthBtn
@onready var reset_max_health_btn: Button = $TestBtnContainers/ResetMaxHealthBtn
@onready var health_label: Label = $TestBtnContainers/HealthLabel
@onready var player: PlayerNew = $Player
@onready var talent_menu_manager: TalentMenuManager = $CanvasLayer/TalentMenuManager


var new_max : float = 100.0

func _ready() -> void:
	var battery : Battery = player.get_node("HUD/Battery")
	print(battery)
	health_label.text = "Health: " + str(player.current_health) + "/" + str(player.max_health)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		_damage_player()

	if Input.is_action_just_pressed("tab"):
		talent_menu_manager.visible = not talent_menu_manager.visible

func _damage_player() -> void:

	player.current_health -= 20.0
	print(player.current_health)
	#player.health_changed.emit()
	_update_label()

func _update_label() -> void:
	health_label.text = "Health: " + str(player.current_health) + "/" + str(player.max_health)


func _on_reset_max_health_btn_pressed() -> void:
	player.max_health = 100.0
	new_max = 100.0
	player.current_health = player.max_health

	_update_label()


func _on_heal_btn_pressed() -> void:
	player.current_health = player.max_health
	_update_label()


func _on_upgrade_max_health_btn_pressed() -> void:
	new_max += 100
	Events.max_health_upgraded.emit(new_max)
	_update_label()


func _on_add_money_btn_pressed() -> void:
	Events.increase_currency.emit(999)
	talent_menu_manager.get_child(1).get_child(1).money = 999
