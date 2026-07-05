class_name Pickup
extends Area2D

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
	var currency_name = type.resource_path.get_file().trim_suffix(".tres")
	
	if area.name == "Magnet":
		if currency_name == "money":
			Events.increase_currency.emit(type.money, type.title)
		elif currency_name == "scrap":
			Events.increase_currency.emit(type.scraps, type.title)
		queue_free()
		print("Type is " + currency_name)
