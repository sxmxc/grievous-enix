extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%Version.text = "v%s" % load("res://version.gd").VERSION
	%Copyright.text = "©%s %s" % [load("res://copyright.gd").YEAR, load("res://copyright.gd").ENTITY]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_dev_button_pressed():
	SceneManager.swap_scenes("res://core/battle/scenes/dev_battle.tscn",null, self)
	pass # Replace with function body.


func _on_new_game_button_pressed():
	SceneManager.swap_scenes("res://scenes/dialogue_scenes/intro.tscn",null, self)
	pass # Replace with function body.
