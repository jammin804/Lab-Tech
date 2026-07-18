class_name TalentResource2
extends Resource

@export var talentIcon: Texture2D
@export var is_unlocked:= false

@export var talentName : String
@export_multiline var talentDescription : String

@export var stat : Stat
@export var statValue : int
@export var is_activated : bool = false

enum Stat{HEALTH, BASE_ATTACK, CHARGE_ATTACK, BULLETS_PER_SHOT}
