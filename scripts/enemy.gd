class_name Enemy
extends CharacterBody2D

signal died

#region DEBUG OPTIONS
@export_category("DEBUG OPTIONS")
@export var is_in_debug_mode : bool = false

#endregion

@export_category("Base Variables")
@export var stats: Resource
@export var move_speed : float = 10.0
@export var max_enemy_health : int = 3
@export var current_enemy_health : int = 3
@export var is_in_battle_scene : bool = false

@export_category("Dependency")
@export var canister : PackedScene

var explosion_damage_dealt : int = 40
var is_dead : bool = false

@onready var enemy_sprite: AnimatedSprite2D = $enemy
@onready var hit_flash_anim: AnimationPlayer = $HitFlashAnim
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var destroy_anim: AnimatedSprite2D = $DestroyAnim
@onready var spawner: Marker2D = $Spawner


func _ready() -> void:
	destroy_anim.hide()
	current_enemy_health = max_enemy_health

func _process(delta: float) -> void:
	if not is_dead:
		move_enemy(delta)
	
func take_damage(damage : int) -> void:
	if is_dead:
		return
		
	current_enemy_health -= damage
	
	hit_flash_anim.play("hit")
	
	Events.screen_shake_requested.emit(2.0, 0.5)
	
	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = true
	
	if current_enemy_health <= 0:
		destroy()

func destroy():
	is_dead = true
	died.emit()
	
	enemy_sprite.stop()
	enemy_sprite.hide()
	
	#turn off collsiion so shots can go through and hit the next enemy
	set_deferred("collision_layer", 0)
	set_deferred("collision_mask", 0)
	
	destroy_anim.show()
	destroy_anim.play("default")
	hit_flash_anim.play("death")

	
	
	


func move_enemy(delta):
	if is_in_battle_scene or is_in_debug_mode:
		position.x += move_speed * delta * -1
		enemy_sprite.play()


func _on_hit_flash_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		if canister:
			var new_gear = canister.instantiate()
			new_gear.transform = spawner.global_transform 
			get_tree().get_root().add_child(new_gear)
			
		self.queue_free()
		
		
func _on_lab_battle_scene_start() -> void:
	is_in_battle_scene = true


func _on_lab_uprgrade_scene_start() -> void:
	is_in_battle_scene = false
