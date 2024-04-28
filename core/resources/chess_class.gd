extends Resource
class_name ChessClass

enum PieceType {
	PAWN,
	ROOK,
	KNIGHT,
	BISHOP,
	QUEEN,
	KING
}

@export var display_name : StringName = ""
@export_range(0,10) var base_value : int = 0
@export var piece_type : PieceType

@export var base_move_range : int = 0

@export var only_forward := false
@export var l_type := false
@export var horizontal := false
@export var vertical := false
@export var diagonal := false

func get_movements(pos, mod) -> Array[Vector2i]:
	var moves : Array[Vector2i] = []
	if base_move_range + mod == 0:
		return moves	
	var move_range: int = base_move_range + mod
	for x in range(1,move_range + 1):
		if horizontal:
			moves.append(pos + Vector2i(x,0))
			moves.append(pos + Vector2i(-x ,0))
		if vertical:
			moves.append(pos + Vector2i(0,-x))
			if !only_forward:
				moves.append(pos + Vector2i(0,x))
		if diagonal:
			moves.append(pos + Vector2i(x,x))
			moves.append(pos + Vector2i(-x,x))
			moves.append(pos + Vector2i(-x,-x))
			moves.append(pos +Vector2i(x,-x))
		if l_type:
			for j in range(1, move_range + 1):
				if x != j and (x + j == move_range):
					moves.append(pos + Vector2i(x, j))
					moves.append(pos + Vector2i(x, -j))
					moves.append(pos + Vector2i(-x, j))
					moves.append(pos + Vector2i(-x, -j))
					moves.append(pos + Vector2i(j, x))
					moves.append(pos + Vector2i(j, -x))
					moves.append(pos + Vector2i(-j, x))
					moves.append(pos + Vector2i(-j, -x))
	return moves
