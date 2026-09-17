class_name Playground
extends Node


enum Row {TOP_ROW, BOTTOM_ROW}

@export var enemy_scene: PackedScene


var spawn_points: Array[Marker2D]
var current_row : int
var spawn_point : Marker2D
var enemy: Enemy

@onready var bottom_spawn_point: Marker2D = %BottomSpawnPoint
@onready var switch_collision: Area2D = $Pausable/SwitchCollision
@onready var top_spawn_point: Marker2D = %TopSpawnPoint

func _ready() -> void:
	spawn_points += [bottom_spawn_point, top_spawn_point]
	#enemy.global_position = bottom_spawn_point.global_position
	_spawn_enemy()





func _on_switch_collision_body_entered(body: Enemy) -> void:

	if body.escape_option == body.ESCAPE_OPTIONS.NORMAL:
		_normal_escape_pattern(body)
	if body.escape_option == body.ESCAPE_OPTIONS.SPEED_UP:
		_normal_escape_pattern(body)
		body.current_data.move_speed = 100
	elif body.escape_option == body.ESCAPE_OPTIONS.TELEPORT:
		_teleport_escape_pattern(body)

func _spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	spawn_point = spawn_points.pick_random()

	new_enemy.global_position = spawn_point.global_position
	get_node("Pausable").add_child(new_enemy)

	if bottom_spawn_point.global_position.y == new_enemy.global_position.y: #bottom row
		current_row = 1
		print("On Bottom Row")
	elif top_spawn_point.global_position.y == new_enemy.global_position.y:
		current_row = 0
		print("On Top Row")


func _on_spawn_enemy_button_pressed() -> void:
	_spawn_enemy()



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
