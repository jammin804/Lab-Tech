class_name PlayerStats
extends Resource

enum Form {DEFAULT, COMBINED, AVATAR}

@export var battery_tanks : int = 1
@export var battery_tank_points : int = 100 #how much health is in 1 tank
@export var fire_rate : float = 0.5
@export var elemental_resistance_amount : int = 10 #need to figure out how to set up resistance

#Multiplers
@export var damage_multipler: float = 1.2
@export var fire_rate_multipler: float = 0.8
@export var element_override: WeaponData.Element = WeaponData.Element.DEFAULT

@export var current_weapon : WeaponData = null
@export var sfx: AudioStream = null
@export var current_form: Form = Form.DEFAULT
