extends ReferenceRect
var game_board: ChessBoard


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _can_drop_data(_pos, data):
	return true

func _drop_data(_pos, data):
	var board_position = game_board.world_to_board(get_global_mouse_position())
	print("Data %s dropped at world position: %s board position: %s" % [data.actor_data.actor_name,get_global_mouse_position(), board_position])
	BattleEvents.piece_dropped_on_board.emit(data, board_position)
	call_deferred("queue_free")
