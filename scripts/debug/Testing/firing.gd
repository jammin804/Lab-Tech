class_name Firing
extends Node

@export var spawn_point : Marker2D

var PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")
var is_limit_unlocked : bool = false
var charge_percent : float = 0.0

@onready var shoot_cooldown_timer: Timer = %ShootCooldownTimer


func _process(delta: float) -> void:
#Regular Fire Code
	if Input.is_action_just_pressed("left_click") and shoot_cooldown_timer.is_stopped():
		_shoot(0.0)
		#print("tapped")

#Charge Fire Code
	if Input.is_action_pressed("left_click"):
		charge_percent += delta * 40
		charge_percent = clampf(charge_percent, 0.0, 100.0)
		print("holding")
		if charge_percent == 100.0:
			print("Full Charge")
	if Input.is_action_just_released("left_click"):
		_shoot(charge_percent)
		charge_percent = 0.0
		print("Charge Depleted")

func _shoot(charge_percentage : float):
	#print("fire")
	_check_limiter_lock()
	_check_charge_lock()
	_create_bullet()

	if charge_percentage >= 100.0:
		print("Full Charge Blast!!!")


func _check_charge_lock():
	if PlayerManager.current_stats.can_charge == true:
		print("Can Charge")
	else:
		print("Can't Charge")

func _check_limiter_lock():
	var limiter_unlocked = PlayerManager.current_stats.super_click

	if limiter_unlocked == true:
		shoot_cooldown_timer.wait_time = 0.0
	else:
		shoot_cooldown_timer.wait_time = 1.0
		shoot_cooldown_timer.start()

func _create_bullet() -> void:
	var bullet : Projectile = PROJECTILE_SCENE.instantiate()
	bullet.global_position = spawn_point.global_position
	get_tree().current_scene.add_child(bullet)
