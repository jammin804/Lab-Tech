class_name Battle_Player
extends Player

@export var current_weapon: WeaponData
@export var drain_amount: int = 10
@export var turret: PackedScene

var mouse_is_on_player: bool = false
var is_auto_shoot: bool = false
var is_charging: bool = false
var time_held : float = 0.0
var current_charge_percent : float
var max_charge_percent : float = 100.0
var active_turret : Node2D = null
var final_stats : PlayerStats

var power : int = 1:
	set(value):
		power = value
		%Power.text = "P : " + str(value)

var rapid : float = 0:
	set(value):
		rapid = value
		%Rapid.text = "R : " + str(value)
		
var battery_level : int = 0:
	set(value):
		battery_level = value
		%Battery.text = "B : " + str(value)

var money : int = 0:
	set(value):
		money = value
		%Money.text = str(value)

var level_scraps : int = 0
var level_money : int = 0

var is_result_screen_on : bool = false
var collected_all_currency: bool = false
#Firing Gun
@onready var muzzle: Marker2D = %Muzzle
@onready var spark: Node2D = $Spark
@onready var fire: AudioStreamPlayer2D = $Fire
@onready var shoot_cooldown_timer: Timer = $ShootCooldownTimer

@onready var hit_flash_anim: AnimationPlayer = $HitFlashAnim
@onready var charge_anim: AnimationPlayer = $ChargeAnim

@onready var out_of_battery_alert: Label = $UI/OutOfBatteryAlert
@onready var charge_progress_bar: TextureProgressBar = %ChargeProgressBar
@onready var full_charge_border: TextureProgressBar = %FullChargeBorder
@onready var charge_progress_bar_container: HBoxContainer = $UI/ChargeProgressBarContainer
@onready var charge_bar_location: Marker2D = $ChargeBarLocation


func _ready() -> void:
	super()
	#charge_progress_bar_container.global_position = charge_bar_location.global_position
	PlayerManager.active_player = self
	
	SkillManager.calculate_unlocked_stats()
	final_stats = SkillManager.active_stats
	
	power = final_stats.power
	rapid = final_stats.rapid
	battery_level = final_stats.battery_tanks
	
	money = SaveData.money
	Events.increase_currency.connect(gain_money)
	Events.level_complete.connect(_on_result_screen_shown)
	battery_empty.connect(_on_result_screen_shown)
	print("Battle Player Ready! Super Click: ", final_stats.super_click, " | Auto Fire: ", final_stats.auto_fire, " | Charge: ", final_stats.can_charge)
	
	
	hit_flash_anim.play("RESET")
	
	_reset_state()

func _input(event) -> void:
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_SPACE:
			health_changed.emit()
	
	
	
func _process(delta: float) -> void:
	var stats = PlayerManager.current_stats
	var percentage = (current_charge_percent / max_charge_percent) * 100
	
	if is_result_screen_on == false:
		if final_stats.can_charge:
			if final_stats.super_click:
				if Input.is_action_just_pressed("left_click") and shoot_cooldown_timer.is_stopped():
					shoot(0.0)
			
			if Input.is_action_pressed("left_click"):
				current_charge_percent += delta * stats.charge_rate
				current_charge_percent = clampf(current_charge_percent, 0.0, max_charge_percent)
				time_held += 1
				#print(time_held)
				if time_held >= 20:
					charge_progress_bar.call_deferred("show") #TODO Polish - make the transition smoother

				charge_progress_bar.value = current_charge_percent
				#When at 100% have the bar modulate with a yellow outline or tint
				if charge_progress_bar.value <= 85 and charge_progress_bar.value >= 80:
					full_charge_border.show()
					charge_anim.play("charging")

				print("Charging my laser " + str(percentage))
					
				
			elif Input.is_action_just_released("left_click"):
				charge_progress_bar.hide()
				full_charge_border.hide()
				charge_anim.play("RESET")
				time_held = 0
				
				var charge_ratio = current_charge_percent / max_charge_percent
				
				if shoot_cooldown_timer.is_stopped() or charge_ratio >= .15:
					shoot(current_charge_percent)
					
				current_charge_percent = 0.0
		else:
			if Input.is_action_just_pressed("left_click") and shoot_cooldown_timer.is_stopped():
				shoot(0.0)
		
		can_auto_fire()
	
	
	if not Input.is_action_just_pressed("left_click"):
		play("Idle")

func shoot(charge_percentage : float) -> void:
	play("Fire") #plays animation
	fire.play() #plays sfx
	
	var new_bullet : Projectile = current_weapon.projectile_node.instantiate()
	var spark_anim = spark.get_child(0)
	spark_anim.play("electric")
	
	
	var player_stats = PlayerManager.current_stats
	var final_fire_rate = player_stats.rapid * player_stats.fire_rate_multipler
	shoot_cooldown_timer.wait_time = final_fire_rate
	shoot_cooldown_timer.start()
	
	var final_damage = player_stats.power * player_stats.damage_multipler
	var final_element = current_weapon.current_element
	
	if final_element == current_weapon.Element.DEFAULT:
		final_element = current_weapon.base_element
	
	#changes the size or sprite depending on how the long the button is held
	var charge_ratio = charge_percentage / max_charge_percent
	var damage_multiper = 1.0
	
	if final_stats.can_charge:

		
		if charge_ratio >= 1.0:
			new_bullet.scale = Vector2(4.0, 4.0)
			damage_multiper = player_stats.charge_damage_multipler
			print("FULL CHARGE SHOT")
		elif charge_ratio >= 0.35:
			new_bullet.scale = Vector2(3.0, 3.0)
			damage_multiper = player_stats.charge_damage_multipler * .75
			print("MID CHARGE SHOT")
		else:
			new_bullet.scale = Vector2.ONE
			damage_multiper = 1.0
			
			print("TAP SHOT")
			
			
	else:
		new_bullet.scale = Vector2.ONE
	
	new_bullet.damage = final_damage * damage_multiper
	new_bullet.current_element = final_element
	new_bullet.global_position = muzzle.global_position

	get_tree().current_scene.add_child(new_bullet)
	damage_player(drain_amount)

			
@warning_ignore("unused_parameter")
func gain_money(amount:int, item_name:String = "money",):
	#print(str(item_name) + " dropped and you gained " + str(amount))
	money += amount
	SaveData.money += amount
	level_money += amount

func can_auto_fire() -> void:
	
	if final_stats.auto_fire and active_turret == null:
		active_turret = turret.instantiate()
		$Attachment.add_child(active_turret)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var enemy_damage = body.explosion_damage_dealt
		
		damage_player(enemy_damage)
		
		health_changed.emit()
		
		hit_flash_anim.play("HitFlashAnim")

func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)

func _on_return_btn_pressed() -> void:
	LevelTransition.change_scene_to("res://scenes/lab.tscn")
	
func _on_result_screen_shown() -> void:
	is_result_screen_on = true
	out_of_battery_alert.show()
	#get_tree().create_timer(2).timeout
	Events.pause_auto_actions.emit()
	#Events.show_result_screen.emit(level_money, level_scraps)

func _reset_state() -> void:
	if is_result_screen_on == true:
		is_result_screen_on = false
		out_of_battery_alert.hide()
