class_name BattlePlayer
extends AnimatedSprite2D


@export var bullet : PackedScene

var is_in_battle_scene : bool = false

@onready var marker_2d: Marker2D = %Marker2D
@onready var timer: Timer = %Timer


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if is_in_battle_scene:
		if timer.is_stopped():
			shoot()
			timer.start()
		else:
			play("Idle")
	else:
		play("Idle")

func shoot() -> void:
	play("Fire")
	var new_bullet = bullet.instantiate()
	new_bullet.transform = marker_2d.global_transform
	get_tree().get_root().add_child(new_bullet)


func _on_lab_battle_scene_start() -> void:
	is_in_battle_scene = true


func _on_lab_uprgrade_scene_start() -> void:
	is_in_battle_scene = false
