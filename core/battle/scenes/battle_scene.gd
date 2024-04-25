extends Node2D
class_name BattleScene

signal scene_ready



@export var chess_piece_scene = preload("res://core/battle/chess_piece/chess_piece.tscn")
@onready var battle_state_machine: StateMachine = $BattleStateMachine
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_scene():
	print("Base BattleScene starting")
	pass

func init_scene():
	print("Base BattleScene initializing")
	$Board.generate_board()
	%SquareInfoDebug.board = %Board
	#await $Board.generation_complete
	print("Board generation complete")
	$BattleCamera.enabled = true
	scene_ready.emit()
	pass

func place_piece_on_board(actor_data: ActorData,  board_position: Vector2i, color: Color = Color.DARK_ORCHID):
	var piece = chess_piece_scene.instantiate() as ChessPiece
	piece.actor_data = actor_data
	piece.piece_color = color
	%PlayerPieces.add_child(piece)
	piece.position = %Board.board_to_world(board_position)

func get_data() -> Dictionary:
	return {}

func receive_data(data: Dictionary):
	pass
