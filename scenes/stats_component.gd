extends Node2D

@export var attributes: AttributeData
@export var health_bar: StatBar

func _ready() -> void:
	if get_parent():
		attributes = get_parent().attribute
		
	if health_bar:
		health_bar.update_bar(get_parent().health, attributes.get_total_life())
		
func update_health_bar(current, max_health):
	if health_bar:
		health_bar.update_bar(current, max_health)
		get_parent().health = current

func _physics_process(delta: float) -> void:
	var new_hp = min(
		get_parent().health, 
		attributes.get_total_life()
	)
	if new_hp != get_parent().health and not health_bar.back_tween.is_running():
		get_parent().health = new_hp
		if health_bar:
			health_bar.update_bar(new_hp, attributes.get_total_life())
