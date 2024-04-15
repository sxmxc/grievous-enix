extends Node2D
class_name BattleScene

signal scene_ready
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_scene():
	print("BattleScene starting")

	pass

func init_scene():
	print("BattleScene initializing")
	$Board.generate_board()
	#await $Board.generation_complete
	print("Board generation complete")
	$BattleCamera.enabled = true
	scene_ready.emit()
	pass

func get_data() -> Dictionary:
	return {}

func receive_data(data: Dictionary):
	pass
