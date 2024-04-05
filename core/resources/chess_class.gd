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
@export_multiline var description: String = ""
@export_range(0,10) var base_value : int = 0
@export var base_skill : ChessSkill = null
@export var piece_type : PieceType

func get_available_moves(_pos: Vector2i) -> Array[Vector2i]:
	#need to implement
	return [Vector2i.ZERO]
	
func get_available_captures(_pos: Vector2i) -> Array[Vector2i]:
	#need to implement
	return [Vector2i.ZERO]
