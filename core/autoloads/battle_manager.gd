extends Node

@export var current_board: ChessBoard = null
@export var square_indicator = null

@export var battle_paused := false

func register_board(board: ChessBoard, indicator):
	current_board = board
	square_indicator = indicator
	BattleEvents.battle_manager_initialized.emit()
