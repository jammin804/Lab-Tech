extends Node

signal loading_progress(progress_amount: float)
signal scene_loaded

const loading_screen_scene: PackedScene = preload("uid://bd2w1mt1l4m31")

var scene_being_loaded: String
var progress: Array[float] = []

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_process(false)

func load_scene(scene_to_load: String) -> void:
	get_tree().paused = true
	var new_loading_screen : LoadingScreen = loading_screen_scene.instantiate()
	loading_progress.connect(new_loading_screen.update_load_progress)
	loading_progress.connect(new_loading_screen.loading_complete)
	get_tree().get_root().add_child(new_loading_screen)

	scene_being_loaded = scene_to_load
	ResourceLoader.load_threaded_request(scene_to_load, "", true)
	set_process(true)


func _process(_delta: float) -> void:
	var loading_state = ResourceLoader.load_threaded_get_status(scene_being_loaded, progress)

	match loading_state:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			printerr("LoadingScreen.gd has failed to load: ", scene_being_loaded)

			var fail_reason: String = "THREAD_LOAD_INVALID_RESOURCE"
			if loading_state == ResourceLoader.THREAD_LOAD_FAILED:
				fail_reason = "THREAD_LOAD_FAILED"
			printerr("loading_state: ", fail_reason)

			set_process(false)
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			emit_signal("loading_progress", progress[0])
		ResourceLoader.THREAD_LOAD_LOADED:
			emit_signal("scene_loaded")
			#LevelTransition.change_scene_to(scene_being_loaded)
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_being_loaded))
			get_tree().paused = false
			set_process(false)
