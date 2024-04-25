extends Node

signal battle_manager_initialized

signal piece_selected(piece: ChessPiece)
signal piece_deselected

signal piece_dropped_on_board(actor_data: Dictionary, pos: Vector2i)

signal piece_move_request(moves: Array[Vector2i])
signal piece_move_cancelled
signal piece_moved
