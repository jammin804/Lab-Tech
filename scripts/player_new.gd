class_name PlayerNew
extends CharacterBody2D

signal health_changed

@export var character_resource: CharacterResource
@export var toggle_debug: bool = false

const TALENT_TREE = preload("res://scenes/UI/New Talent Tree/talent_tree_2.tscn")

var is_talent_tree_open = false
var level_damage_taken : int = 0
var level_damage_done : int = 0
var max_health : float = 100.0
var current_health: float = 100.0:
	set(value):
		current_health = clampf(value, 0.0, max_health)
		health_changed.emit()

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var spark: Node2D = $Spark
@onready var hit_flash_anim: AnimationPlayer = $HitFlashAnim


func _ready() -> void:
	var stats = character_resource.get_character_stats()
	max_health = stats["health"]

	current_health = max_health
	if toggle_debug == true:
		_open_talent_tree()

	Events.max_health_upgraded.connect(_on_max_health_upgraded)
	Events.bullet_fired.connect(_on_bullet_fired)



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		SaveData.save_data["money"] = 999
		SaveData._save()
		print("DEBUG: Game Saved!")

#region Remove this and move it to upgrade scene
func _open_talent_tree():
	is_talent_tree_open = true
	var talentTreeNode : TalentTree2 = TALENT_TREE.instantiate()
	talentTreeNode.active_talents = character_resource.talents
	canvas_layer.add_child(talentTreeNode)

func _close_talent_tree():
	is_talent_tree_open = false
	canvas_layer.get_children()[0].queue_free()
#endregion


func _on_max_health_upgraded(new_max: float) -> void:
	var health_difference = new_max - max_health
	max_health = new_max
	current_health += health_difference

func _on_bullet_fired() -> void:
	spark.get_child(0).play("electric")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var enemy_damage = body.explosion_damage_dealt

		_damage_player(enemy_damage)



func _damage_player(damage_amount: int) -> void:
	level_damage_taken += damage_amount

	current_health -= damage_amount
	hit_flash_anim.play("HitFlashAnim")


	if current_health <= 0:
		_die()

func _die()-> void:
	Engine.time_scale = 0.5
	Events.show_result_screen.emit( 20, 18, 2, 20, 5, 1, "Failed", 3)
	#TODO Have Teleport Animation Like Megamnan
	#battery_empty.emit()
	await get_tree().create_timer(1.0).timeout

	#LevelTransition.change_scene_to("res://scenes/lab.tscn")


func _on_area_2d_mouse_entered() -> void:
	if toggle_debug == true:
		_damage_player(10)


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)
