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
@export var base_movement_skill : MoveSkill = null
@export var piece_type : PieceType
