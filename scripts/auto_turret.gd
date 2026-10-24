class_name AutoTurret
extends Node2D

@export var projectile: PackedScene
@export var attack_speed := 2.0

var turret_damage = 2

@onready var muzzle: Marker2D = $TurretMuzzle
@onready var shot_speed_timer: Timer = $ShotSpeedTimer
@onready var turret_fire: AudioStreamPlayer2D = $TurretFire


func _ready() -> void:
	Events.pause_auto_actions.connect(_stop_firing)
	if shot_speed_timer.autostart == false:
		shot_speed_timer.start()


func _on_shot_speed_timer_timeout() -> void:
	fire()

func fire() -> void:
	turret_fire.play()

	var new_bullet = projectile.instantiate()
	new_bullet.damage = turret_damage
	new_bullet.scale = Vector2.ONE*.5
	new_bullet.global_position = muzzle.global_position
	#print(muzzle.global_position)
	get_tree().current_scene.add_child(new_bullet)
	shot_speed_timer.wait_time = attack_speed
	shot_speed_timer.start()
	#print(shot_speed_timer.wait_time)

func _stop_firing() -> void:
	shot_speed_timer.stop()
