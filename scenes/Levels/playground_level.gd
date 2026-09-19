class_name Playground
extends Node


enum Row {TOP_ROW, BOTTOM_ROW}

@export var level_info : Levels
@export var enemy_scene: PackedScene


var spawn_points: Array[Marker2D]
var spawn_point : Marker2D
var current_row : int
var enemy: Enemy
var num_to_succeed : int
var num_killed : int = 0
var enemies_to_spawn: int:
	set(value):
		enemies_to_spawn = max(0, value)
var is_win_condition_met:bool = false

@onready var bottom_spawn_point: Marker2D = %BottomSpawnPoint
@onready var switch_collision: Area2D = $Pausable/SwitchCollision
@onready var top_spawn_point: Marker2D = %TopSpawnPoint
@onready var enemies_remaining_label: Label = $Pausable/EnemiesRemainingLabel
@onready var spawns_remaining_label: Label = $Pausable/SpawnsRemainingLabel

func _ready() -> void:
	#Initializing signals
	Events.enemy_died.connect(_on_enemy_killed)

	#Setting up spawning points
	spawn_points += [bottom_spawn_point, top_spawn_point]

	#Collecting Condition Gates information
	num_to_succeed = level_info.enemies_to_defeat
	enemies_to_spawn = level_info.enemies_to_spawn

	#Spawing Logic
	_spawn_enemy()

	#Updating UI
	update_kill_counter()
	update_spawn_counter()


	#Add timer



func _on_switch_collision_body_entered(body: Enemy) -> void:

	if body.escape_option == body.ESCAPE_OPTIONS.NORMAL:
		_normal_escape_pattern(body)
	if body.escape_option == body.ESCAPE_OPTIONS.SPEED_UP:
		_normal_escape_pattern(body)
		body.current_data.move_speed = 100
	elif body.escape_option == body.ESCAPE_OPTIONS.TELEPORT:
		_teleport_escape_pattern(body)

func _spawn_enemy() -> void:
	var new_enemy = level_info.enemies_type.pick_random().instantiate()
	spawn_point = spawn_points.pick_random()

	new_enemy.global_position = spawn_point.global_position
	get_node("Pausable").add_child(new_enemy)

	enemies_to_spawn -= 1

	if bottom_spawn_point.global_position.y == new_enemy.global_position.y: #bottom row
		current_row = 1
		print("On Bottom Row")
	elif top_spawn_point.global_position.y == new_enemy.global_position.y:
		current_row = 0
		print("On Top Row")

	if enemies_to_spawn != 0:
		$Pausable/Timer.start()
	else:
		$Pausable/Timer.stop()

func _process(delta: float) -> void:
	_check_enemies_left()


#func _on_spawn_enemy_button_pressed() -> void:
	#_spawn_enemy()



func _normal_escape_pattern(body: Enemy):
	change_lanes(body)
	body.change_direction()

func change_lanes(body: Enemy):
	if is_equal_approx(body.global_position.y, bottom_spawn_point.global_position.y):
		body.global_position.y = top_spawn_point.global_position.y
	else:
		body.global_position.y = bottom_spawn_point.global_position.y

func _teleport_escape_pattern(body) -> void:
	body.global_position.x = %TeleportPoint.global_position.x
	body.change_direction()

func _on_enemy_killed() -> void:
	num_killed += 1
	update_kill_counter()


func update_kill_counter():
	enemies_remaining_label.text = str(num_killed) + "/" + str(num_to_succeed)

	if num_killed >= num_to_succeed:
		enemies_remaining_label.modulate = Color.WEB_GREEN
	else:
		enemies_remaining_label.modulate = Color.WHITE


func update_spawn_counter():
	spawns_remaining_label.text = str(enemies_to_spawn)

	if enemies_to_spawn <= 3:
		spawns_remaining_label.modulate = Color.FIREBRICK
		#TweenFX.heartbeat(spawns_remaining_label)


func _on_timer_timeout() -> void:
	print("spawn enemy if available")
	if enemies_to_spawn >= 0:
		_spawn_enemy()

		update_spawn_counter()
	else:
		return

func _check_enemies_left() -> void:
	var enemies_left = get_tree().get_nodes_in_group("enemy")
	if enemies_left.size() == 0 && enemies_to_spawn == 0:
		_check_win_condition()
		print("Go to lab")
	else:
		print("carry on")


func _check_win_condition():
	if num_killed >= num_to_succeed:
		is_win_condition_met = true
	else:
		is_win_condition_met = false
	print("Win condition ", is_win_condition_met)
