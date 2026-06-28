class_name Battle_Player
extends Player

@export var current_weapon: WeaponData
@export var drain_amount: int = 10

var mouse_is_on_player: bool = false
var is_auto_shoot: bool = false
var is_charging: bool = false
var time_held : float = 0.0
var current_charge_percent : float
var max_charge_percent : float = 100.0

#Firing Gun
@onready var marker_2d: Marker2D = %Marker2D
@onready var spark: Node2D = $Spark
@onready var fire: AudioStreamPlayer2D = $Fire
@onready var shoot_cooldown_timer: Timer = $ShootCooldownTimer
@onready var hit_flash_anim: AnimationPlayer = $HitFlashAnim

func _ready() -> void:
	super()
	PlayerManager.active_player = self
	PlayerManager.load_player_state(self)

func _input(event) -> void:
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_SPACE:
			health_changed.emit()
	
	
func _process(delta: float) -> void:
	var stats = PlayerManager.current_stats
	var percentage = (current_charge_percent / max_charge_percent) * 100
	
	if Input.is_action_just_pressed("ui_select"):
		add_to_max_health(100)
	
	if stats.can_charge:
		if Input.is_action_pressed("left_click"):
			#time_held += delta
		
			current_charge_percent += delta * stats.charge_rate
		
			current_charge_percent = clampf(current_charge_percent, 0.0, max_charge_percent)
			
			print("Charging my laser " + str(percentage))

		elif Input.is_action_just_released("left_click"):
			if shoot_cooldown_timer.is_stopped():
				shoot(current_charge_percent)

			current_charge_percent = 0.0
	else:
		if Input.is_action_just_pressed("left_click") and shoot_cooldown_timer.is_stopped():
			shoot(0.0)
	
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
	
	if player_stats.can_charge:
		if charge_ratio >= 1.0:
			new_bullet.scale = Vector2(4.0, 4.0)
			damage_multiper = player_stats.charge_damage_multipler
			print("FULL CHARGE SHOT")
		elif charge_ratio >= 0.15:
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

	
	new_bullet.global_position = marker_2d.global_position
	
	
		
		
	get_tree().current_scene.add_child(new_bullet)
	damage_player(drain_amount)

	print("Current shoot damage : " + str(new_bullet.damage))

func _on_lab_battle_scene_start() -> void:
	is_in_battle_scene = true

func _on_lab_uprgrade_scene_start() -> void:
	is_in_battle_scene = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var enemy_damage = body.explosion_damage_dealt
		
		damage_player(enemy_damage)
		
		health_changed.emit()
		
		hit_flash_anim.play("HitFlashAnim")


func _on_area_2d_mouse_entered() -> void:
	mouse_is_on_player = true



func _on_area_2d_mouse_exited() -> void:
	mouse_is_on_player = false
