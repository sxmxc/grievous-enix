extends Node

const PLAYER_SAVE_FOLDER = "user://"
const SAVE_FILE_EXTENSION = ".sav"
const DB_FILE_EXTENSION = ".savedb"
const ACTOR_DATA_FILE_PATH = "res://data/actor_data/"
const CLASS_DATA_FILE_PATH = "res://data/chess_classes/"
const SKILL_DATA_FILE_PATH = "res://data/chess_skills/"

var skill_database: Dictionary = {}
var class_database: Dictionary = {}

var actor_database: Dictionary = {}

var scene_database: Dictionary = {}

var player_save_database: Dictionary = {}
var player_data: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_data_from_disk()
	print("DataManager Ready")
	pass # Replace with function body.

func _load_data_from_disk():
	print("DataManager loading data from disk")
	var save_db_file = "%s%s%s" % [PLAYER_SAVE_FOLDER, "player_saves", DB_FILE_EXTENSION]
	if not FileAccess.file_exists(save_db_file):
		print("No Player Save Database found -> Skipping")
		return
	var loaded_file = FileAccess.open(save_db_file, FileAccess.READ)
	player_save_database = loaded_file.get_var()
	loaded_file.close()
	print("DataManager loading data from disk -> Done")
	pass

func _save_data_to_disk():
	print("DataManager saving meta data")
	var save_db_file = "%s%s%s" % [PLAYER_SAVE_FOLDER, "player_saves", DB_FILE_EXTENSION]
	var save = FileAccess.open(save_db_file, FileAccess.WRITE)
	save.store_var(player_save_database)
	save.close()
	print("DataManager saving meta data -> Done")
	pass

func save_game(save_name: String):
	print("DataManager saving player data")
	var player_file = "%s%s%s" % [PLAYER_SAVE_FOLDER, save_name, SAVE_FILE_EXTENSION]
	var save = FileAccess.open(player_file, FileAccess.WRITE)
	save.store_var(player_data)
	save.close()
	player_save_database[save_name] = {
		"date": Time.get_datetime_dict_from_system(),
		"file": player_file
	}
	_save_data_to_disk()
	print("DataManager saving player data -> Done")
	pass
	
func load_game():
	print("DataManager loading game")
	pass
