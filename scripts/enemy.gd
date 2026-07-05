class_name Enemy
extends CharacterBody2D

#signal died

#region DEBUG OPTIONS
@export_category("DEBUG OPTIONS")
@export var is_in_debug_mode : bool = false

#endregion

@export_category("Base Variables")
@export var stats: Resource
@export var is_in_battle_scene : bool = false

@export_category("Item Drop") #TODO Make this into a resource so i can just add to enemy 
@export var loot_drop_type : PackedScene
@export_range(0, 100, 1.0, "suffix:%") var drop_rate

var current_enemy_health : float
var current_data: Resource
var explosion_damage_dealt : int = 40
var is_dead : bool = false

@onready var enemy_sprite: AnimatedSprite2D = $enemy
@onready var status_component: Node = $StatusComponent
@onready var hit_flash_anim: AnimationPlayer = $HitFlashAnim
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var destroy_anim: AnimatedSprite2D = $DestroyAnim
@onready var spawner: Marker2D = $Spawner


func _ready() -> void:
	destroy_anim.hide()
	if stats:
		current_data = stats.duplicate()
		
	#Change health based on level
	current_enemy_health = current_data.health 
	current_enemy_health = floor( (current_enemy_health + 10) * Globals.level * randf_range(1.0, 1.5) )
	print("From Enemy.gd Current Health of this enemy is: ",current_enemy_health)

func _process(delta: float) -> void:
	if not is_dead:
		move_enemy(delta)

	
func take_damage(incoming_damage: float, incoming_element:WeaponData.Element) -> void:
	if is_dead:
		return
		
	var final_damage = incoming_damage
	match incoming_element:
		WeaponData.Element.WATER:
			##Apply wet status
			status_component.apply_status(WeaponData.Element.WATER, 5.0)
		WeaponData.Element.LIGHTING:
			if status_component.has_status(WeaponData.Element.WATER):
				final_damage *= 2.0 #double the damage
				print("SYNERGY: Wet + Lighting")
				#TODO: Trigger chain-lighting visual or AOE here
		WeaponData.Element.FIRE:
			#Apply Burn Status
			status_component.apply_status(WeaponData.Element.FIRE, 3.0)
			
	current_enemy_health -= final_damage
	print("Current Enemy Health: " + str(current_enemy_health))
	
	hit_flash_anim.play("hit")
	#TODO Spawn floating damage numbers here using 'final damage'
	if Globals.can_screenshake == true:
		Events.screen_shake_requested.emit(2.0, 0.5)
	
	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = true
	
	if current_enemy_health <= 0:
		destroy()

func destroy():
	is_dead = true
	Events.enemy_died.emit()
	
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
		position.x += current_data.move_speed * delta * -1
		enemy_sprite.play()

func _drop_item() -> void:
	pass

func _on_hit_flash_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
	
		if loot_drop_type:
			var rng = randf() * 100
			print(rng)
			if rng <= drop_rate:
				var loot = loot_drop_type.instantiate()
				loot.global_transform = spawner.global_transform 
				get_tree().current_scene.add_child(loot)
			
		self.queue_free()

func _on_lab_battle_scene_start() -> void:
	is_in_battle_scene = true

func _on_lab_uprgrade_scene_start() -> void:
	is_in_battle_scene = false
