class_name EnemyProjectile
extends Area2D

@export var show_collision_sprite = true

var direction : Vector2 = Vector2.LEFT
var speed : float = 500.0
var damage : float = 1.0
var has_collided : bool = false
#var life_steal : int = 5
#var is_piercing: bool = false

@onready var hit: AnimatedSprite2D = $Hit
@onready var bullet: Sprite2D = $Bullet

#var current_element : WeaponData.Element = WeaponData.Element.DEFAULT

func _ready() -> void:
	#initalize the signals
	#Events.bullet_fired.connect(_on_bullet_fired)
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

	if body.has_method("_damage_player"):
		#Events.enemy_hit_by_projectile.emit(life_steal)

		body._damage_player(damage, WeaponData.Element.DEFAULT)

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
