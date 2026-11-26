class_name EnemyNew
extends Node2D

@onready var move_component: EnemyMoveComponent = $MoveComponent
@onready var stats_component: EnemyStatsComponent = $StatsComponent
@onready var action_component: Node = $ActionComponent
@onready var shake_component: Node = $ShakeComponent
@onready var flash_component: Node = $FlashComponent

func _ready() -> void:
	#move_component._move_speed = stats_component.enemy_stats.move_speed
	pass

func bind_dependinces() -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	Events.check_remaining.emit()
