class_name EnemyStats
extends Resource

@export var health: int #How much Health does this Enemy have [(Health +10) * Wave Level * RNG(1.0-1.5)]
@export var attack_power: int
@export var move_speed: float
@export var loot_drop : String #TODO Change to only look for Loot Types
@export var loot_drop_rate : float = 1
@export var weakness : WeaponData.Element
@export var weakness_multipler : float = 2.0
@export var has_range_attack : bool = false
@export var rapid : float = 0.0
@export var attack_range : float = 0.0

@export var sprites : SpriteFrames
@export var sfx : AudioStream
