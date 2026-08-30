class_name Enemy_Spawner
extends Node2D

const ENEMY = preload("uid://cqueta70ubjqr")

@export var total_waves : int = 5
@export var current_wave: int
@export var current_number_of_enemies: int
@export var number_enemies_in_wave: int
@export var enemies_left: int
@export var spawn_locations : Array[Marker2D]

@onready var spawn_timer: Timer = $SpawnTimer

var enemies_defeated : int

func _ready() -> void:
	current_wave = Globals.current_wave
	Events.enemy_died.connect(_on_enemy_died)
	#check_wave_number()

func check_wave_number() -> void:
	_reset_enemies_defeat()

	#check player level. If the player is at a certain level spawn from a certain dictonary

	#number_enemies_in_wave = 0
	#print("Current wave is ", current_wave)
	if current_wave == 1:
		#TODO Add animation or show panel when wave is starting. Emit a signal of the UI to listen for it
		#Reset enemies to defeat
		number_enemies_in_wave = 3
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave
		#print("Wave One Start")
	elif current_wave == 2:
		number_enemies_in_wave = 6
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave
		#print("Wave Two Start")
	elif current_wave == 3:
		number_enemies_in_wave = 9
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave
	elif current_wave == 4:
		number_enemies_in_wave = 12
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave
	elif current_wave == 5:
		number_enemies_in_wave = 15
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave
	elif current_wave == 6:
		number_enemies_in_wave = 18
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave
		#print("Wave Two Start")
	elif current_wave == 7:
		number_enemies_in_wave = 21
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave
	elif current_wave == 8:
		number_enemies_in_wave = 24
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave
	elif current_wave == 9:
		number_enemies_in_wave = 27
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave
	elif current_wave == 10:
		number_enemies_in_wave = 30
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		#TODO Add a lable to indicate the current wave



	Events.wave_completed.emit(current_wave, enemies_defeated)

func _on_enemy_died() -> void:

	enemies_left -= 1
	enemies_defeated += 1
	if current_wave == total_waves and enemies_left == 0:
		print(current_wave == total_waves)
		_on_level_end()
	elif enemies_left == 0 and current_wave <= total_waves:
		current_wave += 1
		check_wave_number()


func _on_spawn_timer_timeout() -> void:
	var new_enemey = ENEMY.instantiate()
	#var random_location = spawn_locations.pick_random().global_position
	print("Spawn")

	get_parent().add_child(new_enemey)
	new_enemey.global_position = spawn_locations.pick_random().global_position

	if current_number_of_enemies < number_enemies_in_wave:
		current_number_of_enemies += 1
		enemies_left += 1
		get_parent().add_child(new_enemey)
		new_enemey.global_position = spawn_locations.pick_random().global_position
		print("Choosen Global Position ", new_enemey.global_position)
		#spawn_timer.start()
	else:
		current_number_of_enemies = 0
		#spawn_timer.stop()

func _on_level_end() -> void:
	Events.pause_auto_actions.emit()
	Globals.level += 1
	get_tree().create_timer(2.0).timeout
	Events.level_complete.emit(Globals.level)


func _reset_enemies_defeat():
	enemies_defeated = 0
