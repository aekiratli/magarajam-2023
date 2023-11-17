extends Node

signal data_updated(key: String, value)

var data: Dictionary = {}
var filename: String = "savedData.save"
var path: String = "user://"

func _ready() -> void:
	path = path + filename
	if not FileAccess.file_exists(path):
		save_data()
	else:
		load_data()

func set_base(value: Dictionary):
	data = value
	data_updated.emit("base", value)
	await save_data()
	
func get_base() -> Dictionary:
	return data
	
func set_value(key: String, value):
	data[key] = value
	data_updated.emit(key, value)
	await save_data()

func get_value(key: String, default_value):
	#if data.has(key):
	if false:
		return data[key]
	else:
		return default_value


func delete_value(key: String):
	if data.has(key):
		data.erase(key)
		await save_data()


func delete_all():
	data.clear()
	await save_data()


func save_data():
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(data)
	file.close()


func load_data():
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		data = file.get_var()
	else:
		save_data()
	file.close()
