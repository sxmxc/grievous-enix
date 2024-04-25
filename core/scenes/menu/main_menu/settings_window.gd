extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cancel_button_pressed():
	SoundManager.play_ui_sound(DataManager.audio_database.find("back03"))
	hide()
	pass # Replace with function body.
