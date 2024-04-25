extends Control

signal scene_ready

@export var intro_dialogue: Resource = preload("res://data/dialog/dev_1.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_scene():
	print("Starting intro")
	DialogueManager.show_dialogue_balloon(intro_dialogue)
	DialogueManager.dialogue_ended.connect(func(_args): SceneManager.swap_scenes("res://core/scenes/battle/dev_battle.tscn", null, self))
	pass

func init_scene():
	print("Intro scene initializing")
	scene_ready.emit()
	pass

func get_data() -> Dictionary:
	return {}

func receive_data(data: Dictionary):
	pass
