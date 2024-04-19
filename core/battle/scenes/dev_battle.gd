extends BattleScene

# Called when the node enters the scene tree for the first time.
func _ready():
	BattleEvents.piece_dropped_on_board.connect(_on_piece_dropped_on_board)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_scene():
	print("Initializing dev_battle scene")
	BattleManager.register_board(%Board, %SquareIndicator)
	super.init_scene()
	#Temp
	var piece = chess_piece_scene.instantiate() as ChessPiece
	piece.piece_color = Color.DARK_CYAN

	var random_tile = Vector2i(randi_range(0, %Board.board_width), randi_range(0,%Board.board_height))
	while (%Board.is_square_blocked(random_tile)):
		random_tile = Vector2i(randi_range(0, %Board.board_width), randi_range(0,%Board.board_height))
	%PlayerPieces.add_child(piece)
	piece.position = %Board.board_to_world(random_tile)

func place_piece_on_board(actor_data: ActorData,  board_position: Vector2i, color: Color = Color.DARK_ORCHID):
	var piece = chess_piece_scene.instantiate() as ChessPiece
	piece.actor_data = actor_data
	piece.piece_color = color
	%PlayerPieces.add_child(piece)
	piece.position = %Board.board_to_world(board_position)
	

func _on_piece_dropped_on_board(drop_data, board_position):
	place_piece_on_board(drop_data.actor_data, board_position, drop_data.color)
