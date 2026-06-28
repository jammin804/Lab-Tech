class_name Pickups
extends Area2D

var direction : Vector2
var speed : float = 175.0

@export var type : Currency
@export var player_reference : Player:
	set(value):
		player_reference = value
		type.player_reference = value
		
var can_follow : bool = false
		
func _ready() -> void:
	if not player_reference:
		player_reference = get_tree().get_first_node_in_group("player") as Player
	$Sprite2D.texture = type.icon
	
func _physics_process(delta: float) -> void:
	if player_reference and can_follow:
		direction = (player_reference.position - position).normalized()
		position += direction * speed * delta

func follow(_target : Player):
	can_follow = true


func _on_body_entered(body: Node2D) -> void:
	type.activate()
	queue_free()
