extends CanvasLayer

const RESULT_SCREEN = preload("res://scenes/UI/result_screen_new.tscn")

func _ready() -> void:
	layer = 100

	Events.show_result_screen.connect(_show_result_screen)

func _show_result_screen(enemies_killed:int, damage_done:int, damage_taken:int, money_earned:int, scraps_earned:int, cores_earned:int, success:String, grade:int) -> void:
	var result_screen : ResultScreenNew = RESULT_SCREEN.instantiate()

	add_child(result_screen)

	get_tree().paused = true

	result_screen.setup(enemies_killed, damage_done, damage_taken, money_earned, scraps_earned, cores_earned, success, grade)
