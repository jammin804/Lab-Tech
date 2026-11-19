class_name Enemy_Spawner
extends Node2D

const ENEMY = preload("uid://cqueta70ubjqr")
@export_category("Level Information")
@export var level_info : Resource

@export_category("HUD Labels")
@export var enemies_remaining_label: Label
@export var spawns_remaining_label: Label

@export_category("Spawning Information")
@export var total_waves : int = 5
@export var current_wave: int
@export var current_number_of_enemies: int
@export var number_enemies_in_wave: int
@export var enemies_left: int
@export var spawn_locations : Array[Marker2D]

var current_row : int
var spawn_point : Marker2D
var bottom_spawn_point : Marker2D
var top_spawn_point : Marker2D
var enemies_to_spawn: int:
	set(value):
		enemies_to_spawn = max(0, value)
var total_num_of_enemies_in_level: int
var enemies_defeated : int

@onready var spawn_timer: Timer = $SpawnTimer



func _ready() -> void:

	#Setting up spawning points
	bottom_spawn_point = spawn_locations[0]
	top_spawn_point = spawn_locations[1]

	enemies_to_spawn = level_info.enemies_to_spawn

	total_num_of_enemies_in_level = enemies_to_spawn

	#Spawing Logic
	_spawn_enemy()

	#Updating UI
	#update_kill_counter()
	update_spawn_counter()



func _spawn_enemy() -> void:
	var new_enemy = level_info.enemies_type.pick_random().instantiate()
	spawn_point = spawn_locations.pick_random()

	new_enemy.global_position = spawn_point.global_position
	Events.spawn_enemy.emit(new_enemy)
	#add_child(new_enemy)

	enemies_to_spawn -= 1

	#spawn_locations[0]
	if bottom_spawn_point.global_position.y == new_enemy.global_position.y: #bottom row
		current_row = 1
		print("On Bottom Row")
	elif top_spawn_point.global_position.y == new_enemy.global_position.y:
		current_row = 0
		print("On Top Row")

	if enemies_to_spawn != 0:
		%SpawnTimer.start()
	else:
		%SpawnTimer.stop()


#func update_kill_counter():
	#enemies_remaining_label.text = str(num_killed) + "/" + str(num_to_succeed)
#
	#if num_killed >= num_to_succeed:
		#enemies_remaining_label.modulate = Color.WEB_GREEN
	#else:
		#enemies_remaining_label.modulate = Color.WHITE



func update_spawn_counter():
	spawns_remaining_label.text = str(enemies_to_spawn)

	if enemies_to_spawn <= 3:
		spawns_remaining_label.modulate = Color.FIREBRICK


func _on_spawn_timer_timeout() -> void:
	if enemies_to_spawn >= 0:

		_spawn_enemy()

		update_spawn_counter()
	else:
		return
