class_name Wave_Manager
extends Node

#FIXME Tighten up Wave Manager, Currently the spanwns are off and the enemies and clumping

#signal wave_update

@export_category("Dependencies")
@export var waves: Array[WaveData]
@export var ground_spawn_point : Marker2D
@export var air_spawn_point : Marker2D
@export var enemy_container: Node

var current_wave_index: int = 0
var enemies_alive: int = 0
var enemies_in_wave: int = 0
var level_multipler: float = 1.0

func start_wave():
	if current_wave_index >= waves.size():
		_handle_level_completed()
		return

	var current_wave = waves[current_wave_index]
	enemies_in_wave = 0

	for spawn_group in current_wave.spawns:
		enemies_in_wave += spawn_group.enemy_count
		print(enemies_in_wave)


	if current_wave.is_boss_wave:
		_spawn_boss(current_wave)
	else:
		_spawn_enemies(current_wave)

func _spawn_enemies(wave: WaveData):
	#TODO JUICE: Call an animation signal to tell the wave to start
	var global_spawn_counter: int = 0

	for spawn_group in wave.spawns:
		var valid_points
		if spawn_group.zone == SpawnInfo.SpawnZone.GROUND:
			valid_points = ground_spawn_point
		elif spawn_group.zone == SpawnInfo.SpawnZone.SKY:
			valid_points = air_spawn_point


		for i in range(spawn_group.enemy_count):
			var spawn_point = valid_points

			var enemy = spawn_group.enemy_scene.instantiate()
			var x_offset = global_spawn_counter * 40.0

			enemy.global_position = spawn_point.global_position + Vector2(x_offset, 0)

			enemy.died.connect(_on_enemy_died)

			if enemy_container:
				enemy_container.add_child(enemy)
			else:
				add_child(enemy)

			enemies_alive += 1
			global_spawn_counter += 1
			print("Number of enemies in this wave: " + str(enemies_in_wave))

			if spawn_group.spawn_delay > 0:
				await get_tree().create_timer(spawn_group.spawn_delay).timeout

func _spawn_boss(wave: WaveData):
	#var spawn_point = ground_spawn_point
	var boss = wave.boss_scene.instantiate()
	boss.global_position = ground_spawn_point.global_position
	boss.died.connect(_on_enemy_died)
	if enemy_container:
		enemy_container.add_child(boss)
	else:
		add_child(boss)
	enemies_alive += 1

func _on_enemy_died():
	enemies_alive -= 1
	enemies_in_wave -= 1

	if enemies_alive <= 0 and enemies_in_wave <= 0:
		_complete_wave()

func _complete_wave():
	print('Wave ', current_wave_index + 1, ' Completed!')
	current_wave_index += 1

	await get_tree().create_timer(3.0).timeout
	start_wave()

func _handle_level_completed():
	print("Level Complete!")
	PlayerManager.save_player_state(PlayerManager.active_player)
	LevelTransition.change_scene_to("res://scenes/lab.tscn")
	#TODO Move everything under to the ready of each level or Game State as it will track the how what the level diffuclty multiplier should move to
	#current_wave_index = 0
	#level_multipler += 0.5



func _on_in_between_waves_timeout() -> void:
	print('Start Wave')
	start_wave()
