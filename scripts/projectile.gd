class_name Projectile
extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 750.0
var damage : float = 1.0
var has_collided : bool = false
var life_steal : int = 5

@onready var hit: AnimatedSprite2D = $Hit
@onready var bullet: Sprite2D = $Bullet

var current_element : WeaponData.Element = WeaponData.Element.DEFAULT

func _ready() -> void:
	#print("From projectile" + str(damage))
	pass

func _physics_process(delta: float) -> void:
	if not has_collided:
		position += direction * speed * delta
		#damage = PlayerManager.po

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	# Ignore new collisions if we are already playing the hit animation
	if has_collided:
		return
	
	if body.has_method("take_damage"):
		Events.enemy_hit_by_projectile.emit(life_steal)
		#print(damage)
		
		body.take_damage(damage, WeaponData.Element.DEFAULT)
	
	has_collided = true
	bullet.hide()
	hit.show()
	hit.play("hit")
	
	await hit.animation_finished
	queue_free()
