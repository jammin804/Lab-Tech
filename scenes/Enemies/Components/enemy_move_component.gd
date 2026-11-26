class_name EnemyMoveComponent
extends Node


@export var enemy: Node2D
@export var enemy_sprite: AnimatedSprite2D
@export var enemy_stats: EnemyStatsComponent

var _move_speed: float
var direction: int = -1

func _ready() -> void:
	_move_speed = enemy_stats.enemy_stats.move_speed

func _process(delta: float) -> void:
	enemy.position.x += _move_speed * delta * direction
	enemy_sprite.play("walk")
	#print(enemy_sprite.)


func change_direction():
	direction *= -1
	enemy_sprite.scale.x *= -1
