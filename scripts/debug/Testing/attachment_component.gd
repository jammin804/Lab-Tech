extends Node

@export var spawn_point : Marker2D

var TURRET_SCENE = preload("res://scenes/auto_turret.tscn")
var auto_fire : bool = false

func _ready() -> void:
	_check_can_auto_fire()
	Events.talent_icon_clicked.connect(_spawn_turret)


func _spawn_turret() -> void:
	_check_can_auto_fire()

	var turret : AutoTurret = TURRET_SCENE.instantiate()
	if auto_fire == true:
		spawn_point.add_child(turret)

func _check_can_auto_fire() -> void:
	auto_fire = PlayerManager.current_stats.auto_fire
