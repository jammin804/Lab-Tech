class_name Battle_Player
extends Player

@export var current_weapon: WeaponData
@export var camera : Camera2D
@export var drain_amount: int = 10

var mouse_is_on_player: bool = false
var is_auto_shoot: bool = false
var is_charging: bool = false
var time_held : float = 0.0

#Firing Gun
@onready var marker_2d: Marker2D = %Marker2D
@onready var spark: Node2D = $Spark
@onready var fire: AudioStreamPlayer2D = $Fire
@onready var shoot_cooldown_timer: Timer = $ShootCooldownTimer
@onready var hit_flash_anim: AnimationPlayer = $HitFlashAnim




func _ready() -> void:
	super()
	#var stats = PlayerManager.current_stats
	PlayerManager.active_player = self
	PlayerManager.load_player_state(self)
	

func _input(event) -> void:
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_SPACE:
			health_changed.emit()
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		add_to_max_health(100)
		
	if Input.is_action_pressed("left_click") and mouse_is_on_player:
		time_held += delta
		#TODO Charging should only activate if player has charging skill active
		if time_held > 2.0:
			is_charging = true
		
	if Input.is_action_just_released("left_click") and is_charging == true:
		time_held = 0.0
		shoot()
		is_charging = false
		
	if Input.is_action_just_pressed("left_click") and mouse_is_on_player and shoot_cooldown_timer.is_stopped():
		shoot()
	else:
		play("Idle")

func shoot() -> void:
	play("Fire") #plays animation
	fire.play() #plays sfx
	
	var new_bullet : Projectile = current_weapon.projectile_node.instantiate()
	var spark_anim = spark.get_child(0)
	spark_anim.play("electric")
	
	
	var player_stats = PlayerManager.current_stats
	var final_fire_rate = current_weapon.base_rapid * player_stats.fire_rate_multipler
	shoot_cooldown_timer.wait_time = final_fire_rate
	shoot_cooldown_timer.start()
	
	var final_damage = current_weapon.base_power * player_stats.damage_multipler
	var final_element = current_weapon.current_element
	
	if final_element == current_weapon.Element.DEFAULT:
		final_element = current_weapon.base_element
	if not is_charging:
		new_bullet.damage = final_damage
	else:
		new_bullet.damage = final_damage * player_stats.damage_multipler
	new_bullet.current_element = final_element
	
	new_bullet.global_transform = marker_2d.global_transform
	
	if is_charging == true:
		new_bullet.scale = Vector2(2, 2)
		
	else:
		new_bullet.scale = Vector2.ONE
		
		
	get_tree().current_scene.add_child(new_bullet)
	damage_player(drain_amount)


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
