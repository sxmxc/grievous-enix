extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_dev_button_pressed():
	SceneManager.swap_scenes("res://scenes/dialogue_scenes/intro.tscn",null, self)
	pass # Replace with function body.
