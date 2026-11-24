class_name EnemyProjectile
extends Area2D

@export var show_collision_sprite = true

var direction : Vector2 = Vector2.LEFT
var speed : float = 100.0
var damage : float = 1.0
var has_collided : bool = false
var block: int = 2

@onready var hit: AnimatedSprite2D = $Hit
@onready var bullet: Sprite2D = $Bullet


func _ready() -> void:

	pass

func _physics_process(delta: float) -> void:
	if not has_collided:
		position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	# Ignore new collisions if we are already playing the hit animation
	if has_collided:
		return

	if body.is_class("PlayerNew"):
		print("Hi I am player")

	if body.has_method("damage_player"):
		body.damage_player(damage, WeaponData.Element.DEFAULT)

		has_collided = true
		bullet.hide()

	if has_collided == true:
		if show_collision_sprite == true:
			hit.show()
			hit.play("hit")

			await hit.animation_finished
			queue_free()
		queue_free()


func _on_bullet_fired(_charge) -> void:
	#if charge >= 100:
		#is_piercing = true
	pass


func remove_block()->void:
	if block > 0:
		block -= 1
	else:
		queue_free()
