extends BattleScene

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	%BattleStateLabel.text = battle_state_machine.current_state_name
	BattleEvents.piece_dropped_on_board.connect(_on_piece_dropped_on_board)
	pass # Replace with function body.

func start_scene():
	print("dev_battle scene starting")
	if !DataManager.dialogue_state["tutorial_played"]:
		BattleManager.battle_paused = true
		print("Starting intro")
		play_tutorial()
		await DialogueManager.dialogue_ended
		DataManager.dialogue_state["tutorial_played"] = true
		print("Intro complete, resuming game")
		BattleManager.battle_paused = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_scene():
	print("Initializing dev_battle scene")
	BattleManager.register_board(%Board, %SquareIndicator)
	super.init_scene()
	##Temp
	#var piece = chess_piece_scene.instantiate() as ChessPiece
	#piece.piece_color = Color.DARK_CYAN
#
	#var random_tile = Vector2i(randi_range(0, %Board.board_width), randi_range(0,%Board.board_height))
	#while (%Board.is_square_blocked(random_tile)):
		#random_tile = Vector2i(randi_range(0, %Board.board_width), randi_range(0,%Board.board_height))
	#%PlayerPieces.add_child(piece)
	#piece.position = %Board.board_to_world(random_tile)


func _on_piece_dropped_on_board(drop_data, board_position):
	SoundManager.play_sound(DataManager.audio_database.find("drop"))
	place_piece_on_board(drop_data.actor_data, board_position, drop_data.color)

func play_tutorial():
	DialogueManager.show_dialogue_balloon(DataManager.dialogue_database.find("battle_intro"))
	pass
