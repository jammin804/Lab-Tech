extends TextureButton
class_name Clicker

signal clicker_pressed

@export var can_click: bool

@onready var cta: Label = $"../CTA"
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var click_sound: AudioStreamPlayer2D = %ClickSound
@onready var steam_sound: AudioStreamPlayer2D = %SteamSound

func _ready() -> void:
	can_click = true

func _on_pressed() -> void:
	if cta:
		cta.hide()
		cta.queue_free()
	
	#May have to polish this juice
	if can_click and not click_sound.playing:
		click_sound.play()
		animation_player.play("small_shake")
		emit_signal("clicker_pressed")
		
