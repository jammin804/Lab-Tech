extends Player

@export var bullet : PackedScene

signal battle_health_changed(amount: int)
#signal exp_changed

#var is_in_battle_scene : bool = false

@onready var marker_2d: Marker2D = %Marker2D

@onready var shoot_cooldown_timer: Timer = $ShootCooldownTimer
@onready var mob: Mob = $"../Mob"
@export var player: Player

var battle_max_health
var battle_current_health


func _ready() -> void:
	battle_max_health = player.max_health
	battle_current_health = player.current_health
	print(battle_current_health)
	pass
	
	
func _process(delta: float) -> void:
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
	print(body)
