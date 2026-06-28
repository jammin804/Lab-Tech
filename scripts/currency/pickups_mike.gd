class_name Pickup
extends Area2D

#signal increase_currency(item_name : String)

var direction : Vector2
var speed : float = 175.0

@export var type : Currency:
	set(value):
		type = value
@export var player_reference : Player

func _ready() -> void:
	if not player_reference:
		player_reference = get_tree().get_first_node_in_group("player") as Player
	

func _process(delta: float) -> void:
	if player_reference:
		var step = speed * delta
		
		global_position = global_position.move_toward(player_reference.global_position, step) 


func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.has_method("gain_money"):
		print("reached player")


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Magnet":
		queue_free()
		Events.increase_currency.emit(type.title, type.money)
