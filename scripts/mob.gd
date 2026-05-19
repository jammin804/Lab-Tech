class_name Mob
extends RigidBody2D

signal enemy_health_changed
signal damage

@export var move_speed : float = 10.0
@export var enemy_health : int = 3

var explosion_damage_dealt : int = 40
var is_in_battle_scene : bool = false

@onready var enemy: AnimatedSprite2D = $enemy


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if is_in_battle_scene:
		position.x += move_speed * delta * -1
	else:
		enemy.play()

func _on_lab_battle_scene_start() -> void:
	is_in_battle_scene = true


func _on_lab_uprgrade_scene_start() -> void:
	is_in_battle_scene = false
