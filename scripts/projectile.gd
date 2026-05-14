class_name Projectile
extends Area2D


var speed: int = 750

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	
func _on_bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
