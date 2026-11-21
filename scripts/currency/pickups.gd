class_name Pickup
extends Area2D

var direction : Vector2
var speed : float = 175.0
var collected: bool
var money_amount: int = 0
var can_click: bool = false

#POLISH 11/20 Have the currency explode from enemy using particles and have them magentize to player and increase the money, similar to Well Dweller
@export var type : Currency:
	set(value):
		type = value
@export var player_reference : PlayerNew

func _ready() -> void:
	if not player_reference:
		player_reference = get_tree().get_first_node_in_group("player") as PlayerNew

	#Initalizing Signals
	Events.update_curreny_amount.connect(_on_update_currency)


func _process(delta: float) -> void:
	if player_reference and player_reference.is_magnetize == true:
		var step = speed * delta

		global_position = global_position.move_toward(player_reference.global_position, step)


func _on_body_entered(body: Node2D) -> void:
	#print(body)
	if body.has_method("gain_money"):
		#print("reached player")
		pass


func _on_area_entered(area: Area2D) -> void:
	var currency_name = type.resource_path.get_file().trim_suffix(".tres")

	#print("Currency name ", currency_name)
	if area.name == "Magnet":
		if currency_name == "money":
			Events.increase_currency.emit(type.money, type.title)
			print("Money added")

		elif currency_name == "scrap":
			Events.increase_currency.emit(type.scraps, type.title)

		queue_free()
		#print("Type is " + currency_name)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if can_click:
			Events.increase_currency.emit(type.money, money_amount)
			#print("Money added")
			queue_free()


func _on_update_currency(amount) -> void:
	money_amount = amount


func _on_mouse_entered() -> void:
	can_click = true
	print("Can click?")


func _on_mouse_exited() -> void:
	can_click = false
	print("Can't Click")
