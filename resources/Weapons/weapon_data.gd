class_name WeaponData
extends Resource

#TODO Help creating kill tree and have the skill tree communicate with the weapon stats with passives and changing the types of bullets passed on element type and synergies

enum Element {DEFAULT, EARTH, WATER, WIND, FIRE, LIGHTING, VOID}

@export var title : String
@export var texture : Texture2D


@export_category("Base Stats Info")
@export var base_power : float = 5.0 #this is my name for damage
@export var base_rapid : float = 0.1 # this my name for fire rate
@export var base_range : float = 10.0 # the attack range (or effective range, maybe the bullet disappears once it pass it effecitive range)
@export var can_charge : bool = false
@export var base_charge_rate : float = 1.0 #How many clicks/frames/hold time do you need to reach a Charged state with X weapon? This will 
@export var base_charge_multipler : float = 2.0
@export var base_stagger_damage : float = 1.0 # When you land a bullet using X weapon, how many stagger points does it deal?

@export_category("Element Status Info")
@export var base_element: Element = Element.DEFAULT
@export var current_element:Element = Element.DEFAULT
@export var base_burn_chance: float = 0.2 #if element is fire bullets can burn
@export var base_burn_damage: float = 2.0

@export_category("Collision Info")
@export var base_hitbox_size : int = 25
@export var hitbox_collider_shape: String

@export_category("Loot Info")
@export var loot_type : String #What type of loot does this have a chance of dropping when enemy dies
@export var loot_type_chance : float = 0.2 #chance for loot to drop

@export_category("Effects")
@export var bullet_visual: PackedScene #What bullet should appear when fired
@export var vfx: PackedScene  #what bullet collisions should show when enemy is hit or destoryed b

@export var projectile_node : PackedScene = preload("res://scenes/projectile.tscn")
