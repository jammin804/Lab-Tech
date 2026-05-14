extends AnimatedSprite2D

@export var bullet : PackedScene
@export var max_fire_delay : float = 1.0 

var fire_delay
var velocity = Vector2()
var screen_size

@onready var marker_2d: Marker2D = %Marker2D
@onready var timer: Timer = %Timer


func _ready() -> void:
	#fire_delay = max_fire_delay
	screen_size = get_viewport_rect().size
	print(screen_size)
	
func _process(delta: float) -> void:
	if timer.is_stopped():
		shoot()
		timer.start()
	else:
		play("Idle")


func shoot() -> void:
	play("Fire")
	var new_bullet = bullet.instantiate()
	#owner.add_child(new_bullet)
	new_bullet.transform = marker_2d.global_transform
	get_tree().get_root().add_child(new_bullet)
