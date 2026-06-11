extends Resource
class_name AttributeData

@export var vitality: float = 0.0

@export var max_life: float = 100.0

@export var vitality_health_scaling: float = 1.0

func get_total_life() -> float:
	return max_life + (vitality * vitality_health_scaling)
