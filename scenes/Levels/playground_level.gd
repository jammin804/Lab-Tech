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

	if bottom_spawn_point.global_position.y == enemy.global_position.y: #bottom row
		current_row = 1
		print("On Bottom Row")
	elif top_spawn_point.global_position.y == enemy.global_position.y:
		current_row = 0
		print("On Top Row")



func _on_switch_collision_body_entered(body: Enemy) -> void:

	if body.escape_option == body.ESCAPE_OPTIONS.NORMAL:
		_normal_escape_pattern(body)
	if body.escape_option == body.ESCAPE_OPTIONS.SPEED_UP:
		_normal_escape_pattern(body)
		body.current_data.move_speed *= 2
	elif body.escape_option == body.ESCAPE_OPTIONS.TELEPORT:
		_teleport_escape_pattern()

func _spawn_enemy() -> void:
	enemy = enemy_scene.instantiate()
	spawn_point = spawn_points.pick_random()

	enemy.global_position = spawn_point.global_position
	get_node("Pausable").add_child(enemy)


func _on_spawn_enemy_button_pressed() -> void:
	_spawn_enemy()



func _normal_escape_pattern(body: Enemy):
	change_lanes(body)

	Events.change_direction.emit()


func change_lanes(body):
	if body.is_in_group("enemy") and current_row == Row.BOTTOM_ROW:
		#print("Can move to the top")
		enemy.global_position.y = top_spawn_point.global_position.y

	elif body.is_in_group("enemy") and current_row == Row.TOP_ROW:
		#print("Can move to the bottom")
		enemy.global_position.y = bottom_spawn_point.global_position.y

func _teleport_escape_pattern() -> void:
	enemy.global_position.x = %TeleportPoint.global_position.x
	Events.change_direction.emit()
