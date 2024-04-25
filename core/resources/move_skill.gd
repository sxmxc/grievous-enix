extends ChessSkill
class_name MoveSkill

#@export var movements: Array[Vector2i]
@export var captures: Array[Vector2i]
@export var move_range_x : int = 0
@export var move_range_y : int = 0
@export var move_range_diag : int = 0

@export var only_forward := false

func get_movements() -> Array[Vector2i]:
	var moves : Array[Vector2i] = []
	if move_range_x == 0 and move_range_y == 0 and move_range_diag == 0:
		return moves
	for x in move_range_x:
		if x == 0:
			x = 1
		moves.append(Vector2i(x,0))
		moves.append(Vector2i(-x ,0))
	for y in move_range_y:
		if y == 0:
			y = 1
		moves.append(Vector2i(0,-y))
		if !only_forward:
			moves.append(Vector2i(0,y))
	for diag in move_range_diag:
		if diag == 0:
			diag = 1
		moves.append(Vector2i(diag,diag))
		moves.append(Vector2i(-diag,diag))
		moves.append(Vector2i(-diag,-diag))
		moves.append(Vector2i(diag,-diag))
	return moves
	
func get_captures() -> Array[Vector2i]:
	return captures
