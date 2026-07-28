extends Node2D

const FILE_PATH = "user://SaveFileName.sav"

var save_data: Dictionary = {
	"money" : 0,
	"scrap" : 0,
	"core" : 0,
	"unlocked_talents" : [],
	"skill_tree" : [],
	"branch_names": []
}

func _ready() -> void:
	_load()

func _save():
	var file: FileAccess = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)
	file.close()

func _load():
	if FileAccess.file_exists(FILE_PATH):
		var file: FileAccess = FileAccess.open(FILE_PATH, FileAccess.READ)
		var data: Dictionary = file.get_var()
		if typeof(data) == TYPE_DICTIONARY:
			for i in data:
				if save_data.has(i):
					save_data[i] = data[i]
		file.close()

func has_save_file() -> bool:
	return FileAccess.file_exists(FILE_PATH)

func reset_save() -> void:
	save_data = {
		"money" : 0,
		"scrap" : 0,
		"core" : 0,
		"unlocked_talents" : [],
		"skill_tree" : [],
		"branch_names": []
	}

	_save()
