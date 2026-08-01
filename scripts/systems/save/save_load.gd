extends Node

const save_location = "user://SaveFile.tres"

var SaveFileData : SaveDataResource = SaveDataResource.new()

func _ready() -> void:
	_load()

func _save():
	ResourceSaver.save(SaveFileData, save_location)

func _load():
	if FileAccess.file_exists(save_location):
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)
		print("Save File Data", SaveFileData)

func _reset_save_file():
	SaveFileData = SaveDataResource.new()
	_save()

func has_save_file() -> bool:
	return FileAccess.file_exists(save_location)
