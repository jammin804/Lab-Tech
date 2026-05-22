class_name Mob
extends RigidBody2D

signal enemy_health_changed
signal damage

#region DEBUG OPTIONS
@export_category("DEBUG OPTIONS")
@export var is_in_debug_mode : bool = false

#endregion

@export_category("Base Variables")
@export var move_speed : float = 10.0
@export var enemy_health : int = 3

var explosion_damage_dealt : int = 40
@export var is_in_battle_scene : bool = false

@onready var enemy: AnimatedSprite2D = $enemy
@onready var hit_flash_anim: AnimationPlayer = $HitFlashAnim


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if is_in_battle_scene or is_in_debug_mode:
		position.x += move_speed * delta * -1
		enemy.play()
		
	else:
		enemy.play()

func _on_lab_battle_scene_start() -> void:
	is_in_battle_scene = true


func _on_lab_uprgrade_scene_start() -> void:
	is_in_battle_scene = false
	
func take_damage(damage : int) -> void:
	enemy_health -= damage
	hit_flash_anim.play("hit")
	if enemy_health <= 0:
		#Call enemy health depleated signal
		self.queue_free()
