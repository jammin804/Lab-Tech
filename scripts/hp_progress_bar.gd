extends TextureProgressBar
class_name HealthBar

@export var player: Player
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var hp_numbers: Label = %HpNumbers

var health_warning_anim

func _ready():
	#health_warning_anim = animation_player.get_animation("health_warning")
	#health_warning_anim.loop_mode = Animation.LOOP_LINEAR
	
	player.health_changed.connect(update_hpbar)
	update_hpbar()

func update_hpbar():
	value = player.current_health * 100 / player.max_health
	if value < (25.0 / player.max_health) * 100:
		animation_player.play("health_warning")
	else:
		animation_player.stop()
		
	hp_numbers.text = str(value) + "/ " + str(player.max_health)
