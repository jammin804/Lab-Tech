extends Control
class_name StatBar

@export var back_bar: TextureProgressBar
@export var front_bar: TextureProgressBar
@export var battle_player: Battle_Player

@export var is_health: bool = false
@export var low_hp_pulse: bool = true
@export var damage_shake: bool = true
@onready var player: Player = $"../BattlePlayer/Player"

var current_percent := 1.0
var front_tween: Tween
var back_tween: Tween
var pulse_tween: Tween = null

var current_health: float = 0.0
var max_health: float = 0.0

func _ready() -> void:
	player.health_changed.connect(update_bar)
	current_health = player.current_health
	max_health = player.max_health


func _input(event) -> void:
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_SPACE:
			update_bar(current_health - 10, max_health)

func update_bar(current: float, max_value: float):
	var percent = clamp(current / max_value, 0.0, 1.0)
	
	front_bar.max_value = max_value
	back_bar.max_value = max_value
	
	var is_damage = percent < current_percent
	var is_heal = percent > current_percent
	
	if is_damage:
		if front_tween and front_tween.is_running():
			front_tween.kill()
		if back_tween and back_tween.is_running():
			back_tween.kill()
		
		front_bar.value = current
		
		back_tween = create_tween()
		back_tween.tween_property(back_bar, "value", current, 0.45)
		_on_damage()
		
		
	elif is_heal:
		if front_tween and front_tween.is_running():
			front_tween.kill()
		if back_tween and back_tween.is_running():
			back_tween.kill()
			
		front_tween = create_tween().set_parallel()
		front_tween.tween_property(front_bar, "value", current, 0.25)
		front_tween.tween_property(back_bar, "value", current, 0.25)
		_on_heal()
		
	current_percent = percent
	
	if is_health:
		_check_low_hp_pulse(percent)
	
func _shake() -> void:
	var original_pos = position
	var tween = create_tween()
	tween.tween_property(self, "position", original_pos + Vector2(2,0), 0.05)
	tween.tween_property(self, "position", original_pos - Vector2(2,0), 0.05)
	tween.tween_property(self, "position", original_pos, 0.05)
	
func _flash(flash_color: Color) -> void:
	modulate = flash_color
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1), 0.25)

func _on_damage() -> void:
	_flash(Color(1, 0.3, 0.3))
	if damage_shake:
		_shake()

func _on_heal():
	_flash(Color(0.3, 1, 0.3))
	
	
func _check_low_hp_pulse(percent: float) -> void:
	if percent < 0.25:
		if pulse_tween == null or not pulse_tween.is_running():
			if pulse_tween:
				pulse_tween.kill()
				
			pulse_tween = create_tween()
			pulse_tween.set_loops()
			pulse_tween.tween_property(self, "scale", Vector2(1.04, 1.04), .2)
			pulse_tween.tween_property(self, "scale", Vector2(1.00, 1.00), .2)
	else:
		scale = Vector2.ONE
		
		if pulse_tween and pulse_tween.is_running():
			pulse_tween.kill()
			pulse_tween = null
