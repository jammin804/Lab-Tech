extends CharacterBody2D

@export var character_resource: CharacterResource

@onready var canvas_layer: CanvasLayer = $CanvasLayer

const TALENT_TREE = preload("res://scenes/UI/New Talent Tree/talent_tree_2.tscn")

var is_talent_tree_open = false
var level_damage_taken : int = 0
var level_damage_done : int = 0

func _ready() -> void:
	print(character_resource.get_character_stats())
	_open_talent_tree()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and not is_talent_tree_open:
		_open_talent_tree()
	elif event.is_action_pressed("interact") and is_talent_tree_open:
		_close_talent_tree()

func _open_talent_tree():
	is_talent_tree_open = true
	var talentTreeNode : TalentTree2 = TALENT_TREE.instantiate()
	talentTreeNode.active_talents = character_resource.talents
	canvas_layer.add_child(talentTreeNode)

func _close_talent_tree():
	is_talent_tree_open = false
	canvas_layer.get_children()[0].queue_free()
