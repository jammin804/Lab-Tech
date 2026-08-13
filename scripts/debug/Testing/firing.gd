class_name Firing
extends Node

signal drain_battery(amount)

@export var player_anim : AnimatedSprite2D = null
@export var spawn_point : Marker2D
@export var charge_progress_bar_container: HBoxContainer
@export var spawn_offset : float = 30.0
@export var drain_amount: int = 10


var PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")
var num_of_bullets : int = 1
var is_limit_unlocked : bool = false
var can_charge : bool = false
var is_charging : bool = false
var is_shooting : bool = false
var charge_percent : float = 0.0
var charge_scale: Vector2 = Vector2.ONE


@onready var shoot_cooldown_timer: Timer = %ShootCooldownTimer
@onready var fire_sfx: AudioStreamPlayer2D = $Fire
@onready var charging_up_sfx: AudioStreamPlayer2D = $ChargingUp
@onready var charging_repeat_sfx: AudioStreamPlayer2D = $ChargingRepeat


func _process(delta: float) -> void:
	_check_limiter_lock()
	_check_charge_lock()
	_check_number_of_bullets()
	_handle_firing_inputs(delta)
	_handle_animation()


func _handle_firing_inputs(delta: float) -> void:
#Regular Fire Code
	if Input.is_action_just_pressed("left_click") and shoot_cooldown_timer.is_stopped():
		_shoot(0.0)
	else:
		is_shooting = false

#region Charge Fire Code
	if can_charge == true:
		if Input.is_action_pressed("left_click"):
			_process_charging(delta)


		elif Input.is_action_just_released("left_click"):
			_release_charging()
#endregion
func _process_charging(delta: float) -> void:
		if not is_charging:
			charging_up_sfx.play()
			is_charging = true

		charge_percent += delta * 40
		charge_percent = clampf(charge_percent, 0.0, 100.0)

		charge_progress_bar_container.get_child(0).value = charge_percent

		if charge_percent >= 15.0:
			charge_progress_bar_container.show()

		if charge_percent >= 100.0:
			Events.blaster_fully_charged.emit()

func _release_charging() -> void:
	if charge_percent >= 15.0:
		_shoot(charge_percent)

	is_charging = false
	is_shooting = false
	charging_up_sfx.stop()
	charging_repeat_sfx.stop()
	charge_percent = 0.0
	charge_scale = Vector2.ONE
	charge_progress_bar_container.hide()
	Events.charge_released.emit()


func _shoot(charge_percentage : float):
	fire_sfx.play()
	is_shooting = true

	if is_limit_unlocked == true:
		shoot_cooldown_timer.wait_time = 0.5
	elif is_limit_unlocked == false:
		shoot_cooldown_timer.wait_time = 1.0


	if charge_percentage >= 100.0:
		charge_scale = Vector2(2.0, 2.0)
	else:
		charge_scale = Vector2.ONE

	shoot_cooldown_timer.start()

	var burst_count = clampi(num_of_bullets, 1, 4)
	for i in range(burst_count):
		_create_bullet(i, burst_count)

	drain_battery.emit(drain_amount)
	#Events.damage_dealt.emit(drain_amount)
	Events.bullet_fired.emit()

func _create_bullet(bullet_index: int, total_bullets: int) -> void:
	var bullet : Projectile = PROJECTILE_SCENE.instantiate()
	bullet.scale = charge_scale

	var spawn_pos = spawn_point.global_position
	if total_bullets > 1 and not is_charging:
		var center_offset = (total_bullets - 1)/2.0
		spawn_pos.x += (bullet_index + center_offset) * spawn_offset

	bullet.damage = PlayerManager.current_stats.power
	bullet.global_position = spawn_pos
	get_tree().current_scene.find_child("Pausable").add_child(bullet)

func _check_charge_lock():
	can_charge = PlayerManager.current_stats.can_charge

func _check_limiter_lock():
	is_limit_unlocked = PlayerManager.current_stats.super_click

func _check_number_of_bullets():
	num_of_bullets = PlayerManager.current_stats.rapid

func _handle_animation() -> void:
	if is_shooting:
		player_anim.play("Fire")
	else:
		player_anim.play("Idle")

func _on_charging_up_finished() -> void:
	charging_up_sfx.stop()
	charging_repeat_sfx.play()
