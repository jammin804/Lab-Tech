class_name Currency
extends Resource

@export var title : String
@export var icon : Texture2D
@export_multiline var description : String

var player_reference : Player

func activate():
	print(title + " picked up.")
