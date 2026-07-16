class_name UpgradeButton
extends TextureButton

@export var skill: Skill

@onready var tooltip = $Tooltip
@onready var description = $Tooltip/RichTextLabel

var enabled : bool = false:
	set(value):
		enabled = value
		$Panel.show_behind_parent = value

func _ready() -> void:
	if skill:
		texture_normal = skill.texture
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	
	
		
func is_upgradable() -> bool:
	var branch_name = get_parent().name.to_snake_case()
	var main_ui : Skill_Tree = owner
	
	if branch_name != "super_click":
		if not main_ui.is_upgrade_unlocked("super_click", 0):
			return false
	
	if branch_name != "super_click" and branch_name != "auto_fire":
		if not main_ui.is_upgrade_unlocked("auto_fire", 0):
			return false
	
	if get_index() == 0:
		return true
	else:
		if get_parent().get_child(get_index() - 1).enabled == true:
			return true
	#elif get_index() > 0:
		#if get_parent().get_child(get_index() - 1).enabled == true:
			#return true
		#else:
			#return false
	
	return false


func _on_pressed() -> void:
	if skill.cost <= SaveData.money and is_upgradable() and not enabled:
		SaveData.money -= skill.cost
		enabled = true
		#SaveData.set_and_save()
		get_parent().get_parent().get_parent().on_upgrade_purchased()
		#get_parent().get_parent().get_parent().get_total_stats()
	else:
		print("Cannot afford upgrade or prerequisite not met")

func on_mouse_entered() -> void:
	
	if enabled:
		tooltip.toggle(false)
	else:	
		tooltip.toggle(true)
		description.text = "[b]{name}[/b] - cost: [color=yellow]{cost}[/color]".format({
			"name": skill.name,
			"cost": skill.cost,
		})
		
		print(skill.name + " is being hovered")
		if is_upgradable() and not enabled and skill.cost <= SaveData.money:
			description.text += "\n Can Purchase"
			
	
func on_mouse_exited() -> void:
	tooltip.toggle(false)
