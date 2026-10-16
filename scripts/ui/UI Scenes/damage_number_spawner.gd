class_name DamageNumberSpawner
extends Node2D

@export var label_settings: LabelSettings
@export var critical_hit_color: Color = Color.GOLDENROD

func spawn_label(number: float, critical_hit: bool = false) -> void:
	var new_label: Label = Label.new()

	new_label.text = str(number if step_decimals(number) != 0 else number as int)
	new_label.label_settings = label_settings.duplicate()
	new_label.z_index = 1000
	new_label.pivot_offset_ratio = Vector2(0.5, 1.0)

	if critical_hit:
		new_label.label_settings.font_color = critical_hit_color

	#For lighting in your game
	var label_material: CanvasItemMaterial = CanvasItemMaterial.new()
	label_material.light_mode = CanvasItemMaterial.LIGHT_MODE_UNSHADED
	new_label.material = label_material

	call_deferred("add_child", new_label)
	await new_label.resized
	new_label.position -= Vector2(new_label.size.x /  2.0, new_label.size.y)
	new_label.position += Vector2(randf_range(-5.0, 5.0), randf_range(-5.0, 5.0))

	var target_rise_pos: Vector2 = new_label.position + Vector2(randf_range(-5.0, 5.0), randf_range(-22.0, -16.0))
	var tween_length: float = 3.0 #0.92
	var label_tween: Tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	label_tween.tween_property(new_label, "position", target_rise_pos, tween_length)
	label_tween.parallel().tween_property(new_label, "scale", Vector2.ONE * 1.35, tween_length)
	label_tween.parallel().tween_property(new_label, "modulate:a", 0.0, tween_length).connect("finished", new_label.queue_free)


#func add_floating_label(text: String, spawn_position:Vector2):
	#
	#var label = Label.new()
	#label.text = text
	#label.label_settings = label_settings
	#label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	#label.z_index = 1000
	#label.top_level = true
	#label.global_position = spawn_position
	#label.global_position.x -= label.size.x/2.0
	#label.global_position.y -= label.size.y
	#add_child(label)
	#
	#var tween = create_tween()
	#tween.set_parallel(true)
	#
	#tween.set_trans()
