class_name Player
extends AnimatedSprite2D

signal health_changed()
signal battery_empty()

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

var is_passives_active : bool

func _ready() -> void:
	#Updated Code:
	var stats = PlayerManager.current_stats #FIXME The autoload wouldn't allow me to name is GlobalPlayerManager
	recalculate_max_health()
	current_health = max_health
	
	match stats.current_form:
		PlayerStats.Form.DEFAULT:
			print("Base Form")
		PlayerStats.Form.COMBINED:
			print("Player Unlocked All Friends. Now is Voltron")
		PlayerStats.Form.AVATAR:
			print("Player has now mastered all elements. They are the avatar")
			
		
	Events.player_spawned.emit(self)
	
	health_changed.emit()

func recalculate_max_health():
	max_health = PlayerManager.current_stats.battery_tanks * PlayerManager.current_stats.battery_tank_points

func damage_player(damage_amount: int) -> void:
	current_health -= damage_amount
	current_health = clampf(current_health, 0.0, max_health)
	
	if current_health <= 0:
		print("Return to Lab")
		Engine.time_scale = 0.5
#		#Show Result Screen
		#TODO Have Teleport Animation Like Megamnan
		battery_empty.emit()
		await get_tree().create_timer(1.0).timeout
		
		LevelTransition.change_scene_to("res://scenes/lab.tscn")
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

func add_to_max_health(increase_amount: int):
	PlayerManager.current_stats.battery_tanks += 1
	recalculate_max_health()
	current_health = max_health
	#print("Player -> Add Health: Max Player health is:" + str(max_health))
	health_changed.emit()
	
