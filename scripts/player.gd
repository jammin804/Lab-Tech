class_name Player
extends AnimatedSprite2D

signal health_changed()

@export_category("Debug")
@export var debug_regen: bool = true

@export_category("Health Data")
@export var can_regen_health: bool = true
@export var has_been_hit: bool = false
@export var regen_amount: float = 2.0
@export var regen_rate: = 100.0
@export var max_health: float = 100.0
@export var current_health: float
@export var regen_cap = max_health/3

#Stats

@export_category("Experience Data")
@export var current_exp: float = 20.0
@export var max_exp: float = 100.0

@export_category("Scene Check")
@export var is_in_battle_scene : bool = false
@export var is_in_upgrade_scene : bool = false

@onready var regen_timer: Timer = %RegenTimer
@onready var last_time_hit_timer: Timer = %LastTimeHitTimer
@onready var battle_player: AnimatedSprite2D = $"../../BattleScreen/BattlePlayer"

var is_passives_active : bool

func _ready() -> void:
	Events.player_spawned.emit(self)
	
	current_health = max_health
	health_changed.emit()

func damage_player(damage_amount: int) -> void:
	current_health -= damage_amount
	current_health = clampf(current_health, 0.0, max_health)

	health_changed.emit()

func regen_health() -> void: #This should only be for in battle otherwise fill health to 100%
	if current_health < max_health and can_regen_health == true:
		current_health += regen_amount / regen_rate
		health_changed.emit()
	elif current_health >= max_health:
		can_regen_health = false
		

func _on_regen_timer_timeout() -> void:
	can_regen_health = true


func _on_last_time_hit_timer_timeout() -> void:
	has_been_hit = false
	regen_timer.start()


func _on_lab_uprgrade_scene_start() -> void:
	is_in_upgrade_scene = true
	is_in_battle_scene = false
	current_health = max_health
	health_changed.emit()


func _on_lab_battle_scene_start() -> void:
	is_in_battle_scene = true
	is_in_upgrade_scene = false
	regen_timer.start()
	

func _can_use_passives() -> void:
	if current_health == 0:
		is_passives_active = false
	else:
		is_passives_active = true

#FIXME: Fix the max health clampping
func add_to_max_health(increase_amount: int):
	max_health += increase_amount
	max_health = clamp(max_health, 0, 300)
	current_health = max_health
	print("Player -> Add Health: Max Player health is:" + str(max_health))
	health_changed.emit()
	
