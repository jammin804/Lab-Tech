class_name TalentResource
extends Resource

@export var talentIcon: Texture2D
@export var is_unlocked:= false
#@export var prerequisites: Array[TalentResource]
@export var unlockTalents: Array[TalentResource]

@export var talentName : String
@export_multiline var talentDescription : String

@export var stat : Stat
@export var statValue : int

enum Stat{HEALTH, BASE_ATTACK, CHARGE_ATTACK, BULLETS_PER_SHOT}
