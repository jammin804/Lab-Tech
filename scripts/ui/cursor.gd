extends Sprite2D

#FIXME Fix custom cursor fly in bug
var hotspot : Vector2 = Vector2(16, 16)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	global_position = get_global_mouse_position()
	
func _process(delta: float) -> void:
	global_position =  get_global_mouse_position()
	
	var desired_rotation: float = -12.5 if Input.is_action_just_pressed("left_click") else 0.0
	rotation_degrees = lerp(rotation_degrees, desired_rotation, 16.5*delta)
	
	var desired_scale: Vector2 = Vector2(0.05, 0.05) if Input.is_action_pressed("left_click") else Vector2(0.025, 0.025)
	scale = lerp(scale, desired_scale, 16.5*delta)
	
