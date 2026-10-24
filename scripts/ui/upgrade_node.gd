class_name Upgrade_Node
extends Control

@export var icon: TextureButton
@export var level: int = 0
@export var level_label: Label

func _ready() -> void:
	update_level_label()
	
	
func update_level_label() -> void:
	if level_label:
		level_label.text = str(level)


func _on_icon_pressed() -> void:
	 #if current_currency >= skill_cost:
	level+=1 
	update_level_label()
