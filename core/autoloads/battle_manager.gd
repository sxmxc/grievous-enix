extends Node

var current_board: ChessBoard = null
var square_indicator = null

func register_board(board: ChessBoard, indicator):
	current_board = board
	square_indicator = indicator
	BattleEvents.battle_manager_initialized.emit()
