extends Node

const PLAYER_SAVE_FOLDER = "user://"
const SAVE_FILE_EXTENSION = ".sav"
const DB_FILE_EXTENSION = ".savedb"
const ACTOR_DATA_FILE_PATH = "res://data/actor_data/"
const CLASS_DATA_FILE_PATH = "res://data/chess_classes/"
const SKILL_DATA_FILE_PATH = "res://data/chess_skills/"

var skill_database:= Database.new()
var class_database:= Database.new()

var actor_database:= Database.new()

var scene_database:= Database.new()

var player_save_database:= Database.new()
var player_data:= Database.new()

var user_prefs: UserPrefs

var dialogue_state: Dictionary = {
	"intro_played" : false,
	"tutorial_played" : false,
	"test_int" : 0,
	"test_key": "blah"
}

var dialogue_database:= Database.new()

var audio_database:= Database.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_data_from_disk()
	audio_database.add("menu_intro_song", preload("res://assets/audio/music/Enter the Abyss.mp3"))
	audio_database.add("battle_song_1", preload("res://assets/audio/music/Pixel Nightmares.mp3"))
	audio_database.add("back03",preload("res://addons/kenney_interface_sounds/back_003.wav") )
	audio_database.add("click",preload("res://addons/kenney_interface_sounds/click_004.wav") )
	audio_database.add("confirm", preload("res://addons/kenney_interface_sounds/confirmation_002.wav"))
	audio_database.add("drop", preload("res://addons/kenney_interface_sounds/drop_003.wav"))
	audio_database.add("error", preload("res://addons/kenney_interface_sounds/back_004.wav"))
	
	dialogue_database.add("intro", preload("res://data/dialog/dev_1.dialogue"))
	dialogue_database.add("battle_intro", preload("res://data/dialog/dev_1.dialogue"))
	
	actor_database.add("Dev", preload("res://data/actor_data/dev.tres")as ActorData)
	actor_database.add("Valaris", preload("res://data/actor_data/valaris.tres") as ActorData)
	actor_database.add("Voidmoose", preload("res://data/actor_data/voidmoose.tres")as ActorData)
	print("DataManager Ready")
	pass # Replace with function body.

func _load_data_from_disk():
	print("DataManager loading data from disk")
	var save_db_file = "%s%s%s" % [PLAYER_SAVE_FOLDER, "player_saves", DB_FILE_EXTENSION]
	if not FileAccess.file_exists(save_db_file):
		print("No Player Save Database found -> Skipping")
		return
	var loaded_file = FileAccess.open(save_db_file, FileAccess.READ)
	player_save_database.seed_data(loaded_file.get_var()) 
	loaded_file.close()
	user_prefs = UserPrefs.load_or_create()
	print("DataManager loading data from disk -> Done")
	pass

func _save_data_to_disk():
	print("DataManager saving meta data")
	var save_db_file = "%s%s%s" % [PLAYER_SAVE_FOLDER, "player_saves", DB_FILE_EXTENSION]
	var save = FileAccess.open(save_db_file, FileAccess.WRITE)
	save.store_var(player_save_database.get_data())
	save.close()
	print("DataManager saving meta data -> Done")
	pass

func save_settings():
	print("DataManager saving game settings")
	user_prefs.save()
	print("DataManager saving game settings -> Done")
	pass

func save_game(save_name: String):
	print("DataManager saving player data")
	player_data.add("dialogue_state",dialogue_state)
	var player_file = "%s%s%s" % [PLAYER_SAVE_FOLDER, save_name, SAVE_FILE_EXTENSION]
	var save = FileAccess.open(player_file, FileAccess.WRITE)
	save.store_var(player_data.get_data())
	save.close()
	player_save_database.add(save_name,{
		"date": Time.get_datetime_dict_from_system(),
		"file": player_file
	})
	_save_data_to_disk()
	print("DataManager saving player data -> Done")
	pass
	
func load_game():
	print("DataManager loading game")
	pass
