@tool
extends Control

@export var locked_line_color: Color = Color.GRAY
@export var unlocked_line_color: Color = Color(0, 0.8, 1.0)

func _process(delta):
	queue_redraw()

func _draw():
	for talentNode in get_tree().get_nodes_in_group("talents"):
		if not talentNode.talentResource: continue

		for resource in talentNode.talentResource.unlockTalents:
			var targetNode = _get_node_with_resource(resource)

			if targetNode == null: continue

			var sourcePosition = (talentNode.global_position) + (talentNode.get_center())
			var targetPosition = (targetNode.global_position) + (targetNode.get_center())
			var color = unlocked_line_color if talentNode.talentResource.is_unlocked else locked_line_color

			draw_line(sourcePosition, targetPosition, color, 4.0)

func _get_node_with_resource(resource):
	for talentNode in get_tree().get_nodes_in_group("talents"):
		if talentNode.talentResource == resource:
			return talentNode
