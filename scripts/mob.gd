class_name Mob
extends RigidBody2D

signal enemy_health_changed

@export var move_speed : float = 10.0
@export var enemy_health : int = 3
var explosion_damage_dealt : int = 4



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.x += move_speed * delta * -1
	#print(position.x)
