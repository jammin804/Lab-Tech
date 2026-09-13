class_name Playground
extends Node


enum Row {TOP_ROW, BOTTOM_ROW}

@export var enemy_scene: PackedScene


var spawn_points: Array[Marker2D]
var current_row : Row
var spawn_point : Marker2D
var enemy: Enemy

@onready var bottom_spawn_point: Marker2D = %EnemySpawnPoint
@onready var switch_collision: Area2D = $Pausable/SwitchCollision
@onready var top_spawn_point: Marker2D = %EnemySpawnPoint2

func _ready() -> void:
	spawn_points += [bottom_spawn_point, top_spawn_point]
	#enemy.global_position = bottom_spawn_point.global_position
	_spawn_enemy()

	if bottom_spawn_point.global_position.y == enemy.global_position.y: #bottom row
		current_row = Row.BOTTOM_ROW
		print("On Bottom Row")
	elif top_spawn_point.global_position.y == enemy.global_position.y:
		current_row = Row.TOP_ROW
		print("On Bottom Row")



func _on_switch_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and current_row == Row.BOTTOM_ROW:
		print("Can move to the top")
		#Move Up
		enemy.global_position.y = top_spawn_point.global_position.y
		#Change Directon movement backwards

	elif body.is_in_group("enemy") and current_row == Row.TOP_ROW:
		print("Can move to the bottom")
		enemy.global_position.y = bottom_spawn_point.global_position.y

	Events.change_direction.emit()

func _spawn_enemy() -> void:
	enemy = enemy_scene.instantiate()
	spawn_point = spawn_points.pick_random()

	enemy.global_position = spawn_point.global_position
	get_node("Pausable").add_child(enemy)


func _on_spawn_enemy_button_pressed() -> void:
	_spawn_enemy()
