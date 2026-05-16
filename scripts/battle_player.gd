extends AnimatedSprite2D

@export var bullet : PackedScene

@onready var marker_2d: Marker2D = %Marker2D
@onready var timer: Timer = %Timer


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if timer.is_stopped():
		shoot()
		timer.start()
	else:
		play("Idle")

func shoot() -> void:
	play("Fire")
	var new_bullet = bullet.instantiate()
	new_bullet.transform = marker_2d.global_transform
	get_tree().get_root().add_child(new_bullet)
