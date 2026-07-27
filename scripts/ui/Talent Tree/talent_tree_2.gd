@tool
extends Control
class_name TalentTree2

@export var active_talents:Array[TalentResource2]= []

@export var locked_line_color: Color = Color.GRAY
@export var unlocked_line_color: Color = Color(0, 0.8, 1.0)

func _ready() -> void:
	Events.talent_icon_clicked.connect(_on_talent_purchased)
	_refresh_tree_state()

func _process(_delta) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _draw() -> void:
	var all_talent_nodes = get_tree().get_nodes_in_group("talents")

	for talent_node in all_talent_nodes:
		if not talent_node.get("talent_resource") or not talent_node.talent_resource:
			continue

		for req_id in talent_node.talent_resource.prerequisites:
			var prereq_node = _get_node_by_id(req_id, all_talent_nodes)

			if prereq_node == null:
				continue

			var source_pos = prereq_node.global_position + (prereq_node.size / 2.0)
			var target_pos = talent_node.global_position + (talent_node.size / 2.0)

			var color = unlocked_line_color if talent_node.talent_resource.is_unlocked else locked_line_color

			draw_line(source_pos, target_pos, color, 4.0)

func _get_node_by_id(id: String, all_nodes: Array) -> Node:
	for node in all_nodes:
		if node.get("talent_resource") and node.talent_resource:
			if node.talent_resource.talent_id == id:
				return node
	return null

func _on_talent_purchased() -> void:
	_refresh_tree_state()

func _refresh_tree_state() -> void:
	active_talents.clear()

	var all_talent_nodes = get_tree().get_nodes_in_group("talents")

	for talent_node in all_talent_nodes:
		if talent_node.talent_resource.is_unlocked:
			active_talents.append(talent_node.talent_resource)

	for talent_node in all_talent_nodes:
		if talent_node.talent_resource.is_unlocked:
			talent_node.get_child(1).disabled = true
			continue

		var can_purchase = _check_prerequisites(talent_node.talent_resource)

		if can_purchase:
			talent_node.get_child(1).disabled = false
		else:
			talent_node.get_child(1).disabled = true

	queue_redraw()

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
