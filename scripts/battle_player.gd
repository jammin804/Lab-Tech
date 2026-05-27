extends Player

@export var bullet : PackedScene
@export var fire_rate : float = 0.5 #will be replaced by rapid stat pulled from resources


signal battle_health_changed(amount: int)

@onready var marker_2d: Marker2D = %Marker2D
@onready var hit_flash_anim: AnimationPlayer = $HitFlashAnim

@onready var shoot_cooldown_timer: Timer = $ShootCooldownTimer
@onready var mob: Mob = $"../Mob"

var battle_max_health: float
var battle_current_health: float
var is_auto_shoot: bool



func _ready() -> void:
	battle_max_health = max_health
	battle_current_health = current_health
	
	shoot_cooldown_timer.wait_time = fire_rate
	shoot_cooldown_timer.one_shot = true

	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click") and shoot_cooldown_timer.is_stopped():
		shoot()
		shoot_cooldown_timer.start()
		
	if is_in_battle_scene:
		if shoot_cooldown_timer.is_stopped():
			shoot()
			shoot_cooldown_timer.start()
		else:
			play("Idle")
			
	else:
		play("Idle")

func shoot() -> void:
	play("Fire")
	var new_bullet = bullet.instantiate()
	new_bullet.transform = marker_2d.global_transform
	get_tree().get_root().add_child(new_bullet)


func _on_lab_battle_scene_start() -> void:
	is_in_battle_scene = true

func _on_lab_uprgrade_scene_start() -> void:
	is_in_battle_scene = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var enemy = body
		battle_health_changed.emit(enemy.explosion_damage_dealt)
		hit_flash_anim.play("HitFlashAnim")
	print(body)
