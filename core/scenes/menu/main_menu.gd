extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.play_music(DataManager.audio_database["menu_intro_song"])
	%Version.text = "v%s" % load("res://version.gd").VERSION
	%Copyright.text = "©%s %s" % [load("res://copyright.gd").YEAR, load("res://copyright.gd").ENTITY]
	$SettingsWindow.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_dev_button_pressed():
	SoundManager.play_ui_sound(DataManager.audio_database["confirm"])
	SceneManager.swap_scenes("res://core/battle/scenes/dev_battle.tscn",null, self)
	SoundManager.stop_music(5)
	pass # Replace with function body.


func _on_new_game_button_pressed():
	SoundManager.play_ui_sound(DataManager.audio_database["confirm"])
	#SceneManager.swap_scenes("res://scenes/dialogue_scenes/intro.tscn",null, self)
	pass # Replace with function body.


func _on_settings_button_pressed():
	SoundManager.play_ui_sound(DataManager.audio_database["click"])
	$SettingsWindow.show()
	pass # Replace with function body.
