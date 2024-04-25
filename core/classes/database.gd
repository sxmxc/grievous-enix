extends RefCounted
class_name Database

var _data : Dictionary

func _init():	
	_data.clear()
	_data = {}

func add(key: StringName, value):
	_data[key] = value

func exists(key: StringName) -> bool:
	return _data.has(key)
	
func find(key: StringName):
	if _data.has(key):
		return _data[key]
	return null

func get_data() -> Dictionary:
	return _data

func seed_data(data: Dictionary):
	_data.clear()
	_data = data
