@tool
extends Control
class_name TalentTree2

@export var active_talents:Array[TalentResource2]= []

@export var locked_line_color: Color = Color.GRAY
@export var unlocked_line_color: Color = Color(0, 0.8, 1.0)
@export var available_border_color: Color = Color.GOLD
@export var current_money_label: Label

@export_category("Skill Tree Panel Tabs")
@export var info_name_label: Label
@export var info_desc_label: Label
@export var info_cost_label: Label

func _ready() -> void:
	if not Engine.is_editor_hint():
		#Events.talent_icon_clicked.connect(_on_talent_purchased)
		var all_talent_nodes = _get_local_talent_nodes()


		for talent_node in all_talent_nodes:
			var resource = talent_node.talent_resource
			var button = talent_node.get_child(1)

			if not resource or not button:
				continue

			button.focus_mode = Control.FOCUS_NONE

			if SaveData.save_data["unlocked_talents"].has(resource.talent_id):
				resource.is_unlocked = true

			button.mouse_entered.connect(_on_talent_hovered.bind(talent_node.talent_resource))
			button.mouse_exited.connect(_on_talent_unhovered)
			button.pressed.connect(_attempt_purchase.bind(resource))

		_update_money_ui()
		_refresh_tree_state()
		_on_talent_unhovered()

func _process(_delta) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _draw() -> void:
	var all_talent_nodes = _get_local_talent_nodes()

	for talent_node in all_talent_nodes:
		if not talent_node.get("talent_resource") or not talent_node.talent_resource:
			continue

		for req_id in talent_node.talent_resource.prerequisites:
			var prereq_node = _get_node_by_id(req_id, all_talent_nodes)

			if prereq_node == null:
				continue

			var source_global_center = prereq_node.global_position + (prereq_node.size / 2.0)
			var target_global_center = talent_node.global_position + (talent_node.size / 2.0)

			var source_pos = source_global_center - global_position
			var target_pos = target_global_center - global_position

			var color = unlocked_line_color if talent_node.talent_resource.is_unlocked else locked_line_color

			draw_dashed_line(source_pos, target_pos, color, 2.0, 4.0, true)
			#draw_line(source_pos, target_pos, color, 2.0)

func _get_node_by_id(id: String, all_nodes: Array) -> Node:
	for node in all_nodes:
		if node.get("talent_resource") and node.talent_resource:
			if node.talent_resource.talent_id == id:
				return node
	return null

func _on_talent_purchased() -> void:
	_refresh_tree_state()

func _on_talent_hovered(resource: TalentResource2) -> void:
	if info_name_label:
		info_name_label.text = resource.talentName
	if info_desc_label:
		info_desc_label.text = resource.talentDescription
	if info_cost_label:
		info_cost_label.text = str(resource.cost)

func _on_talent_unhovered()-> void:
	info_name_label.text = "Select a Skill"
	info_desc_label.text = ""
	info_cost_label.text = ""

func _refresh_tree_state() -> void:
	active_talents.clear()

	var all_talent_nodes = _get_local_talent_nodes()

	for talent_node in all_talent_nodes:
		if talent_node.talent_resource.is_unlocked:
			active_talents.append(talent_node.talent_resource)

	for talent_node in all_talent_nodes:
		var button = talent_node.get_child(1)

		if talent_node.talent_resource.is_unlocked:
			button.disabled = true
			_set_icon_border(talent_node, "purchased")
			continue

		var can_purchase = _check_prerequisites(talent_node.talent_resource)

		if can_purchase:
			button.disabled = false
			_set_icon_border(talent_node, "available")
		else:
			button.disabled = true
			_set_icon_border(talent_node, "locked")

	queue_redraw()

func _set_icon_border(talent_node: Node, state: String) -> void:
	var style = StyleBoxFlat.new()
	style.set_border_width_all(2)
	style.bg_color = Color(0, 0, 0, 0)

	match state:
		"purchased":
			style.border_color = unlocked_line_color
		"available":
			style.border_color = available_border_color
		"locked":
			style.border_color = locked_line_color

	talent_node.add_theme_stylebox_override("panel", style)

func _check_prerequisites(resource: TalentResource2) -> bool:
	if resource.prerequisites.is_empty():
		return true

	for required_id in resource.prerequisites:
		var requirement_met = false

		for active_talent in active_talents:
			if active_talent.talent_id == required_id:
				requirement_met = true
				break

		if not requirement_met:
			return false

	return true

func _attempt_purchase(talent_node: TalentIcon) -> void:
	var resource = talent_node.talent_resource
	var functionality = talent_node.talent_functionality

	if SaveData.save_data["money"] >= resource.cost:

		SaveData.save_data["money"] -= resource.cost
		resource.is_unlocked = true
		SaveData.save_data["unlocked_talents"].append(resource.talent_id)
		SaveData._save()

		if functionality != null:
			functionality.action(talent_node)

		_update_money_ui()
		_refresh_tree_state()
	else:
		print("Not enough money! Need: ", resource.cost, " Have: ", SaveData.save_data["money"])

func _update_money_ui() -> void:
	if current_money_label:
		current_money_label.text = str(SaveData.save_data["money"])

func _get_local_talent_nodes() -> Array:
	var local_nodes = []
	var global_nodes = get_tree().get_nodes_in_group("talents")

	for node in global_nodes:
		if self.is_ancestor_of(node):
			local_nodes.append(node)

	return local_nodes
