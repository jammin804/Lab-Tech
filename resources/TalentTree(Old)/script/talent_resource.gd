class_name TalentResource
extends Resource

@export var talentIcon: Texture2D
@export var is_unlocked:= false
@export var unlockTalents: Array[TalentResource]
@export var prerequisiteTalents: Array[TalentResource]

@export var talentName : String
@export_multiline var talentDescription : String

@export var stat : Stat
@export var statValue : int
@export var is_activated : bool = false

enum Stat{HEALTH, BASE_ATTACK, CHARGE_ATTACK, BULLETS_PER_SHOT}
