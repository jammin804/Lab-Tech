class_name LoadingScreen
extends CanvasLayer

@onready var fade_node: Node2D = $fade
@onready var progress_bar: ProgressBar = $fade/ProgressBar
@onready var loading_label: Label = $LoadingLabel
@onready var shader_cache: Node2D = $shader_cache

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	#$shader_cache/hitflash.material
	_loading_label_loop()
	ResourceLoader.load_threaded_get("uid://1lqqs1b6h2wp")
	LoadingSystem.scene_loaded.connect(loading_complete)


func update_load_progress(progress: float) -> void:
	progress_bar.value = progress * 100.0

func loading_complete() -> void:
	progress_bar.value = progress_bar.max_value
	var hide_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	hide_tween.tween_interval(0.2)
	hide_tween.tween_property(fade_node, "modulate:a", 0.0, 0.15).connect("finished", queue_free)


func _loading_label_loop():
	TweenFX.glow_pulse(loading_label)
