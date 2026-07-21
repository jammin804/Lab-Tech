class_name Firing
extends Node

@export var spawn_point : Marker2D
@export var charge_progress_bar_container: HBoxContainer
@export var spawn_offset : float = 30.0

var PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")
var num_of_bullets : int = 1
var is_limit_unlocked : bool = false
var can_charge : bool = false
var is_charging : bool = false
var charge_percent : float = 0.0
var charge_scale: Vector2 = Vector2.ONE


@onready var shoot_cooldown_timer: Timer = %ShootCooldownTimer


func _process(delta: float) -> void:
	_check_limiter_lock()
	_check_charge_lock()
	_check_number_of_bullets()

#Regular Fire Code
	if Input.is_action_just_pressed("left_click") and shoot_cooldown_timer.is_stopped():
		_shoot(0.0)

#Charge Fire Code
	if can_charge == true:
		if Input.is_action_pressed("left_click"):
			is_charging = true
			charge_percent += delta * 40
			charge_percent = clampf(charge_percent, 0.0, 100.0)

			charge_progress_bar_container.get_child(0).value = charge_percent

			if charge_percent >= 15.0:
				charge_progress_bar_container.show()

			if charge_percent == 100.0:
				pass

		elif Input.is_action_just_released("left_click"):
			if charge_percent >= 15.0:
				_shoot(charge_percent)

			is_charging = false
			charge_percent = 0.0
			charge_scale = Vector2.ONE
			charge_progress_bar_container.hide()



func _shoot(charge_percentage : float):
	if is_limit_unlocked == true:
		shoot_cooldown_timer.wait_time = 0.5
	elif is_limit_unlocked == false:
		shoot_cooldown_timer.wait_time = 1.0


	if charge_percentage >= 100.0:
		charge_scale = Vector2(2.0, 2.0)
		#print("Full Charge Blast!!!")
	else:
		charge_scale = Vector2.ONE

	shoot_cooldown_timer.start()

	var burst_count = clampi(num_of_bullets, 1, 4)
	for i in range(burst_count):
		_create_bullet(i, burst_count)

func _check_charge_lock():
	can_charge = PlayerManager.current_stats.can_charge

func _check_limiter_lock():
	is_limit_unlocked = PlayerManager.current_stats.super_click

func _check_number_of_bullets():
	num_of_bullets = PlayerManager.current_stats.rapid

func _create_bullet(bullet_index: int, total_bullets: int) -> void:
	var bullet : Projectile = PROJECTILE_SCENE.instantiate()
	bullet.scale = charge_scale

	var spawn_pos = spawn_point.global_position
	if total_bullets > 1 and not is_charging:
		var center_offset = (total_bullets - 1)/2.0
		spawn_pos.x += (bullet_index + center_offset) * spawn_offset

	bullet.global_position = spawn_pos
	get_tree().current_scene.add_child(bullet)
