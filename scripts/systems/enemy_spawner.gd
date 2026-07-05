extends Node2D

const ENEMY = preload("uid://cqueta70ubjqr")

@export var total_waves : int = 3
@export var current_wave: int
@export var current_number_of_enemies: int
@export var number_enemies_in_wave: int
@export var enemies_left: int

@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	current_wave = Globals.current_wave
	Events.enemy_died.connect(_on_enemy_died)
	check_wave_number()

#func _process(delta: float) -> void:
	#pass

func check_wave_number() -> void:
	#number_enemies_in_wave = 0
	print("Current wave is ", current_wave)
	if current_wave == 1:
		#TODO Add animation or show panel when wave is starting. Emit a signal of the UI to listen for it
		number_enemies_in_wave = 3
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		print("Wave One Start")
	elif current_wave == 2:
		number_enemies_in_wave = 6
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		print("Wave Two Start")
	elif current_wave == 3:
		number_enemies_in_wave = 9
		await get_tree().create_timer(2).timeout
		spawn_timer.start()
		


func _on_enemy_died() -> void:
	
	enemies_left -= 1

	if enemies_left == 0 and current_wave <= total_waves:
		current_wave += 1
		check_wave_number()
	elif current_wave == total_waves:
		#TODO Emit signal for result scene to show
		pass
		#Globals.level += 1
		#LevelTransition.change_scene_to("res://scenes/lab.tscn")


func _on_spawn_timer_timeout() -> void:
	var new_enemey = ENEMY.instantiate()
	#new_enemey.global_position = global_position
	
	if current_number_of_enemies < number_enemies_in_wave:
		current_number_of_enemies += 1
		enemies_left += 1
		get_parent().add_child(new_enemey)
		new_enemey.global_position = global_position
		spawn_timer.start()
	else:
		current_number_of_enemies = 0
		spawn_timer.stop()
