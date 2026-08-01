class_name PlayerNew
extends CharacterBody2D

signal health_changed

@export var character_resource: CharacterResource
@export var toggle_debug: bool = false

const TALENT_TREE = preload("res://scenes/UI/New Talent Tree/talent_tree_2.tscn")

var is_talent_tree_open = false
var level_damage_taken : int = 0
var level_damage_done : int = 0
var level_enemies_killed : int = 0
var level_money: int = 0
var level_scraps : int = 0
var level_cores : int = 0

var max_health : float = 100.0
var current_health: float = 100.0:
	set(value):
		current_health = clampf(value, 0.0, max_health)
		health_changed.emit()

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var spark: Node2D = $Spark
@onready var hit_flash_anim: AnimationPlayer = $HitFlashAnim
@onready var firing_component: Firing = $FiringComponent


func _ready() -> void:
	#_load_skills()
	var stats = character_resource.get_character_stats()
	max_health = stats["health"]

	current_health = max_health

	#Remove the toggle_debug
	if toggle_debug == true:
		_open_talent_tree()

	Events.max_health_upgraded.connect(_on_max_health_upgraded)
	Events.bullet_fired.connect(_on_bullet_fired)
	Events.enemy_died.connect(func(): level_enemies_killed += 1)
	Events.damage_dealt.connect(_on_damage_done)
	Events.increase_currency.connect(_on_currency_gained)



#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#SaveLoad.SaveFileData.money = 999
		#SaveLoad.SaveFileData._save()
		#print("DEBUG: Game Saved!")
#
	#if event.is_action_pressed("ui_right"):
		#if is_talent_tree_open == false:
			#_open_talent_tree()
		#else:
			#_close_talent_tree()

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

func _on_damage_done(amount: int) -> void:
	level_damage_done += amount
	print("Current level damage ", level_damage_done)

func _on_currency_gained(amount: int, type_title: String="money") -> void:
	print(type_title)
	if type_title == "Money":
		level_money += amount
		SaveLoad.SaveFileData.money +=  amount
		print("Current Money ", level_money)

	elif type_title == "Scrap":
		level_scraps += amount
		SaveLoad.SaveFileData.scrap += amount

	elif type_title == "Core":
		level_cores += amount
		SaveLoad.SaveFileData.core += amount


	SaveLoad._save()

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
	var status: String = "Failed"
	var grade: int = 0

	Events.show_result_screen.emit(level_enemies_killed, level_damage_done, level_damage_taken, level_money, level_scraps, level_cores, status, grade)
	#TODO Have Teleport Animation Like Megamnan
	#battery_empty.emit()
	await get_tree().create_timer(1.0).timeout
	#save when


func _on_area_2d_mouse_entered() -> void:
	#if toggle_debug == true:
		#_damage_player(10)
	pass


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)



func _load_skills():
	#May remove
	print("Load Skills")
	#print("Current Skills to Load ", SaveLoad.SaveFileData.unlocked_talents)
	for talent in SaveLoad.SaveFileData.unlocked_talents:
		print("Talents that need be to loaded ", talent)

func _on_firing_component_drain_battery(amount: Variant) -> void:
	current_health -= amount
