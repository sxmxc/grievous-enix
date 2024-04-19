class_name UserPrefs extends Resource

@export_range(0,1,.05) var music_volume: float = 1.0
@export_range(0,1,.05) var sfx_volume: float = 1.0

const USER_PREFS_PATH:String = "user://user_prefs.tres"

func save() -> void:
	print("Saving UserPrefs")
	ResourceSaver.save(self, USER_PREFS_PATH)
	print("Saving UserPrefs -> Done")
	
static func load_or_create() -> UserPrefs:
	var res:UserPrefs
	if FileAccess.file_exists(USER_PREFS_PATH):
		print("Loading existing UserPrefs")
		res = load(USER_PREFS_PATH) as UserPrefs
		print("Loading existing UserPrefs -> Done")
	else:
		print("Creating UserPrefs")
		res = UserPrefs.new()
		print("Creating UserPrefs -> Done")
	return res
