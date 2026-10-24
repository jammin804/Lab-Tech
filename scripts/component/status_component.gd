class_name StatusComponent
extends Node

# Key = Element Enum, Value = Float (Time remaining)
var active_statuses: Dictionary = {}

func _process(delta: float) -> void:
	for element_key in active_statuses.keys():
		active_statuses[element_key] -= delta
		
		if active_statuses[element_key] <= 0:
			active_statuses.erase(element_key)
			_on_status_expired(element_key)
func apply_status(element: WeaponData.Element, duration: float) -> void:
	active_statuses[element] = duration
	_on_status_applied(element)

func has_status(element: WeaponData.Element) -> bool:
	return active_statuses.has(element)
	
func _on_status_expired(element: WeaponData.Element) -> void:
	match element:
		WeaponData.Element.WATER:
			# e.g., Restore the parent enemy's original movement speed
			pass

func _on_status_applied(element: WeaponData.Element) -> void:
	match element:
		WeaponData.Element.WATER:
			# e.g., Tell the parent enemy to slow its movement speed by 20%
			pass
		WeaponData.Element.FIRE:
			# e.g., Start a repeating damage-over-time tick
			pass
	
