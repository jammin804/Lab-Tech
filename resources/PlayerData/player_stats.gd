class_name PlayerStats
extends Resource

#TODO Help creating skill tree and have the skill tree communicate with the player stats with passives
enum Form {DEFAULT, COMBINED, AVATAR}

enum upgrades {ADD_DAMAGE, ADD_DAMAGE_MULTI, ADD_ATTACK_SPEED, ADD_BULLET, ADD_TO_BULLET, ADD_HEALTH, ADD_TO_CHARGE, REDUCE_CHARGE_RATE, ADD_SHIELD}

@export var battery_tanks : int = 1 #Player Max HP
@export var battery_tank_points : int = 100 #how much health is in 1 tank
#@export var fire_rate : float
@export var elemental_resistance_amount : int #need to figure out how to set up resistance

#Multiplers
@export var damage_multipler: float  = 1.0
@export var fire_rate_multipler: float = 1.0
@export var element_override: WeaponData.Element = WeaponData.Element.DEFAULT

@export var current_weapon : WeaponData = null
@export var sfx: AudioStream = null
@export var current_form: Form = Form.DEFAULT

#Attributes
@export var super_click : bool = false
@export var auto_fire : bool = false
@export var power : int = 15
#@export var range : int = 2
@export var rapid : int = 1 #Bullets per shot
@export var can_charge : bool = true
@export var charge_rate : float = 40.0
@export var charge_damage_multipler : float = 2.0
@export var double_down : bool = false



#TODO [URGENT] 11/11: Continue to work on getting the upgrades to fit with the player stats. Link the remaining upgrades
#region Testing Code for upgrade

#Base Stats
#var damage = 200
#var hp = 100
#var bullets = 1
#
##Upgrade Stats
#var addHealth = 0
#var damageMulti = 0
#var attackSpeedMulti = 0


#endregion
